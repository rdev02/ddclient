**Dynamic DNS client
**

###**Fork from yaronr/ddclient**

Use this to register a server in a DNS that supports dynamic DNS.

Usage:
`docker run --rm rdev02/ddclient:latest  {dynamic_dns_server} {your_domain} {password} {dynamic_dns_protocol} {host} {sleep_interval_sec}`

{sleep_interval_sec} default = 3600, -1 means execute once and exit, with the appropriate exit code. Any other number / default - This process will exit, if the DNS registration is not successful (or it is terminated / interrupted). Otherwise it will continuously update the DNS.

All other params are required.

**Example:
**

`docker run --rm rdev02/ddclient:latest dynamicdns.park-your-domain.com mydomain.com pass1234 namecheap my-dns-server-name
`

**Note:
**
Some DNS providers require that a DNS 'A' record of the type you're trying to update, will pre-exist, for the update to succeed. To overcome this, just set a fake A record to 127.0.0.1 for the server you plan to update using ddclient (in the example above, vpn-${CLUSTER_NAME})