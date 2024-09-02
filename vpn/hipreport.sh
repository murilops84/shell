#!/bin/sh
IP=$(ip a | grep wlan | awk -F ' ' 'NR==2 { print $2 }' | awk -F '/' '{ print $1 }')
HIP_DATE=$(date +%m/%d/%Y' '%T)
MONTH=$(date +%-m)
DAY=$(date +%-d)
YEAR=$(date +%Y)
IP_ADDRESS=$(ip -o -4 addr show | grep tun0 | awk '{split($4, a, "/"); print a[1]}')
cat<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<hip-report>
	<md5-sum>3662652970f81dc4ae1ca83fe7e847</md5-sum>
	<user-name>${GP_USERNAME}</user-name>
	<domain></domain>
	<host-name>${GP_HOSTNAME}</host-name>
	<host-id>8c82e8cc-a0e5-4e31-b1a3-c4061e4d6f74</host-id>
	<ip-address>${IP_ADDRESS}</ip-address>
	<ipv6-address></ipv6-address>
	<generate-time>${HIP_DATE}</generate-time>
	<hip-report-version>4</hip-report-version>
	<categories>
		<entry name="host-info">
			<client-version>6.1.0-58</client-version>
			<os>Microsoft Windows 11 Enterprise , 64-bit</os>
			<os-vendor>Microsoft</os-vendor>
			<domain>${GP_DOMAIN}</domain>
			<host-name>${GP_HOSTNAME}</host-name>
			<host-id>8c82e8cc-a0e5-4e31-b1a3-c4061e4d6f74</host-id>
			<network-interface>
				<entry name="{D461D1B7-7278-4DB9-AD4B-AB159FF6C99C}">
					<description>PANGP Virtual Ethernet Adapter Secure</description>
					<mac-address>02-50-41-00-00-01</mac-address>
					<ip-address>
						<entry name="${IP_ADDRESS}"/>
					</ip-address>
				</entry>
				<entry name="{11C8E3C7-76E5-4FE3-A0E9-47EBD8A41D3B}">
					<description>Realtek PCIe GbE Family Controller #2</description>
					<mac-address>00-BE-43-82-7F-DC</mac-address>
					<ip-address>
						<entry name="169.254.142.68"/>
					</ip-address>
					<ipv6-address>
						<entry name="fe80::847f:f453:1c6:22b7"/>
					</ipv6-address>
				</entry>
				<entry name="{B42B853C-F9E4-40FA-90F5-9B4616ADC95A}">
					<description>Microsoft Wi-Fi Direct Virtual Adapter #3</description>
					<mac-address>00-D7-6D-8B-F5-48</mac-address>
					<ip-address>
						<entry name="169.254.105.101"/>
					</ip-address>
					<ipv6-address>
						<entry name="fe80::f804:72af:7032:43da"/>
					</ipv6-address>
				</entry>
				<entry name="{308CDAD5-5A71-480A-9284-CD82FB93C422}">
					<description>Microsoft Wi-Fi Direct Virtual Adapter #4</description>
					<mac-address>02-D7-6D-8B-F5-47</mac-address>
					<ip-address>
						<entry name="169.254.21.82"/>
					</ip-address>
					<ipv6-address>
						<entry name="fe80::3600:3c1d:d1a:21cd"/>
					</ipv6-address>
				</entry>
				<entry name="{24A452FA-DBBB-4D81-A8C0-AE76B7E06987}">
					<description>Intel(R) Wi-Fi 6 AX201 160MHz #2</description>
					<mac-address>00-D7-6D-8B-F5-47</mac-address>
					<ip-address>
						<entry name="192.168.15.8"/>
					</ip-address>
					<ipv6-address>
						<entry name="2804:1b3:a8c2:3bdb:bbf:4f73:6479:c1cf"/>
						<entry name="2804:1b3:a8c2:3bdb:2c20:ee65:e92c:53f5"/>
						<entry name="fe80::7922:46d8:463e:2042"/>
					</ipv6-address>
				</entry>
				<entry name="{A4DA72EF-CB2E-426F-8435-FAB58811A1A9}">
					<description>Bluetooth Device (Personal Area Network) #2</description>
					<mac-address>00-D7-6D-8B-F5-4B</mac-address>
					<ip-address>
						<entry name="169.254.223.124"/>
					</ip-address>
					<ipv6-address>
						<entry name="fe80::2099:cc69:d602:eaaa"/>
					</ipv6-address>
				</entry>
				<entry name="{F02A7063-FBF2-11EE-AEE8-806E6F6E6963}">
					<description>Software Loopback Interface 1</description>
					<mac-address></mac-address>
					<ip-address>
						<entry name="127.0.0.1"/>
					</ip-address>
					<ipv6-address>
						<entry name="::1"/>
					</ipv6-address>
				</entry>
				<entry name="{2BD0F830-9AB3-4EB4-97CB-5B0FDC61470C}">
					<description>Hyper-V Virtual Ethernet Adapter</description>
					<mac-address>00-15-5D-BC-FD-50</mac-address>
					<ip-address>
						<entry name="172.29.48.1"/>
					</ip-address>
					<ipv6-address>
						<entry name="fe80::1087:84f0:e339:249f"/>
					</ipv6-address>
				</entry>
			</network-interface>
		</entry>
		<entry name="anti-malware">
			<list>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Windows Defender" version="4.18.24070.5" defver="1.417.432.0" engver="1.1.24070.3" datemon="${MONTH}" dateday="${DAY}" dateyear="${YEAR}" prodType="3" osType="1"/>
						<real-time-protection>yes</real-time-protection>
						<last-full-scan-time>n/a</last-full-scan-time>
					</ProductInfo>
				</entry>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Microsoft Defender ATP" version="10.0.22631.3880" defver="2024.09.02" engver="" datemon="${MONTH}" dateday="${DAY}" dateyear="${YEAR}" prodType="3" osType="1"/>
						<real-time-protection>yes</real-time-protection>
						<last-full-scan-time>n/a</last-full-scan-time>
					</ProductInfo>
				</entry>
			</list>
		</entry>
		<entry name="disk-backup">
			<list>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Windows File History" version="10.0.22621.4163"/>
						<last-backup-time>n/a</last-backup-time>
					</ProductInfo>
				</entry>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Windows Backup and Restore" version="10.0.22621.4163"/>
						<last-backup-time>n/a</last-backup-time>
					</ProductInfo>
				</entry>
			</list>
		</entry>
		<entry name="disk-encryption">
			<list>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="BitLocker Drive Encryption" version="10.0.22621.1"/>
						<drives>
							<entry>
								<drive-name>C:\</drive-name>
								<enc-state>encrypted</enc-state>
							</entry>
							<entry>
								<drive-name>All</drive-name>
								<enc-state>encrypted</enc-state>
							</entry>
						</drives>
					</ProductInfo>
				</entry>
			</list>
		</entry>
		<entry name="firewall">
			<list>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Windows Firewall" version="10.0.22621.3672"/>
						<is-enabled>yes</is-enabled>
					</ProductInfo>
				</entry>
			</list>
		</entry>
		<entry name="patch-management">
			<list>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="System Center Configuration Manager Client" version="5.00.9128.1007"/>
						<is-enabled>no</is-enabled>
					</ProductInfo>
				</entry>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Microsoft Intune Management Extension" version="1.81.107.0"/>
						<is-enabled>n/a</is-enabled>
					</ProductInfo>
				</entry>
				<entry>
					<ProductInfo>
						<Prod vendor="Microsoft Corporation" name="Windows Update Agent" version="10.0.22621.3527"/>
						<is-enabled>yes</is-enabled>
					</ProductInfo>
				</entry>
			</list>
			<missing-patches>
				<entry>
					<title>2024-08 Atualização Cumulativa do Windows 11 Version 23H2 para sistemas operacionais baseados em x64 (KB5041585) [REBOOTREQUIRED]</title>
					<description>Instale esta atualização para resolver problemas no Windows. Para obter a lista completa dos problemas incluídos nesta atualização, consulte o artigo da Base de Dados de Conhecimento Microsoft associado. Talvez seja necessário reiniciar o computador após instalar este item.</description>
					<product>Microsoft Windows</product>
					<vendor>Microsoft</vendor>
					<info-url></info-url>
					<kb-article-id>5041585</kb-article-id>
					<security-bulletin-id></security-bulletin-id>
					<severity>-2</severity>
					<category>unknown</category>
					<is-installed>no</is-installed>
				</entry>
			</missing-patches>
		</entry>
		<entry name="data-loss-prevention">
			<list>
			</list>
		</entry>
	</categories>
	<custom-checks>
		<registry-key>
			<entry name="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion">
				<exist>yes</exist>
				<value></value>
				<registry-value>
					<entry name="CurrentBuild">
						<exist>yes</exist>
						<value>22631</value>
					</entry>
				</registry-value>
			</entry>
		</registry-key>
	</custom-checks>
</hip-report>
EOF