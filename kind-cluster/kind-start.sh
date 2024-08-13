#!/bin/bash
set -o errexit

cluster_name='kind'
if [ ! -z $1 ]; then
  cluster_name=$1
fi

# create registry container unless it already exists
if [[ ! -d auth ]] then
	mkdir auth
fi

if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
	docker run --entrypoint htpasswd httpd -Bbn admin admin > auth/htpasswd
	docker run -d --restart=always -p 5000:5000 --name registry_private \
		-v `pwd`/auth:/auth -e "REGISTRY_AUTH=htpasswd" -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
		registry:2
fi

# create a cluster with the local registry enabled in containerd
cat <<EOF | kind create cluster --config=-
kind: Cluster
name: ${cluster_name}
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
    endpoint= ["http://registry_private:5000"]
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    listenAddress: "0.0.0.0"
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    listenAddress: "0.0.0.0"
    protocol: TCP
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
- role: worker
  labels:
    app: dev
networking:
  apiServerAddress: "0.0.0.0"
  apiServerPort: 6443
EOF

# connect the registry to the cluster network if not already connected
if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' registry_private)" = 'null' ]; then
  docker network connect "kind" "registry_private"
fi

# Document the local registry
# https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/generic/1755-communicating-a-local-registry
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:5000"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF

# Document the local registry
# https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/generic/1755-communicating-a-local-registry
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:5000"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF

# Create namespace for development
kubectl create namespace dev

# Create nginx secret
HOST=server.internal
SSL_DIR=$HOME/.ssl
KEY_FILE=tls.key
CERT_FILE=tls.crt
if [[ ! -d ${SSL_DIR} ]] then
	echo 'Create SSL directory'
	$(mkdir -p ${SSL_DIR})
fi

if [[ ! -e ${SSL_DIR}/${CERT_FILE} ]] then
	echo 'Create TLS files'
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${SSL_DIR}/${KEY_FILE} -out ${SSL_DIR}/${CERT_FILE} -subj "/CN=${HOST}/O=${HOST}" -addext "subjectAltName = DNS:${HOST}"
fi

kubectl create -n dev secret tls secret-tls --key=${SSL_DIR}/${KEY_FILE}  --cert=${SSL_DIR}/${CERT_FILE}

# Deploy nginx ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Create metric server
kubectl create -f https://raw.githubusercontent.com/pythianarora/total-practice/master/sample-kubernetes-code/metrics-server.yaml

echo $(kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s)
