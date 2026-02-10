# SSH DNS Tunnel

Tools for access a remote computer using SSH with tunneling local access to private network using sshuttle and Unbound DNS

## Unbound

:link: Dependency: Unbound

### Configuration

Edit `sshuttle.conf` file with company domains and DNS addresses:

```conf
    # Insecure domains
    domain-insecure: "domaincompany.com"
    domain-insecure: "company.com"
    domain-insecure: "database.windows.net"
    domain-insecure: "domain-foo.com"
```

Add a forward-zone for each domain with forward-addr to DNS IPs:

```conf
    forward-zone:
    name: "domaincompany.com"
    forward-addr: 10.1.1.5 # Company DNS IP Address
    forward-addr: 10.1.1.6 # Company DNS IP Address
    forward-first: no
```

Copy sshuttle.conf file to `/etc/unbound/unbound.conf.d/` \
Change your connection to use loopback `127.0.0.1` as DNS Server

### Start Service

Enable and start unbound service

```sh
# systectl enable unbound.service
# systemctl status unbound.service
```

## SSH DNS script

:link: Dependency: sshuttle

### Configuration

Edit `ssh-dns-tunnel` file with DNS IPs addresses and remote network.

```sh
LOCAL_DNS=10.1.1.5,10.1.1.6 #Remote DNS IP Addresses
REMOTE_SERVER=192.168.15.9  #Remote server address
REMOTE_NETWORK=10.0.0.0/8   #Remote network
```

### Running

Copy the `ssh-dns-tunnel` file to a $PATH directory and run the script

```sh
$ ssh-dns-tunnel
```

:bulb: **Tips**
: Configure a ssh-key to connect without need a password.
