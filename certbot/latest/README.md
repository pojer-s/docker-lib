certbot
=======

## Usage

### DNS OVH

* create credentials file

```bash
mdkir letsencrypt
cat <<EOF > ./letsencrypt/dns-ovh-credentials.conf
dns_ovh_endpoint = ovh-eu
dns_ovh_application_key = APP_KEY
dns_ovh_application_secret = APP_SECRET
dns_ovh_consumer_key = CONSUMER_KEY
EOF
```

* generate the cert

```bash
docker run -it --rm --name certbot \
            -v `pwd`/letsencrypt:/etc/letsencrypt \
            spojer/certbot certonly --dns-ovh --dns-ovh-credentials /etc/letsencrypt/dns-ovh-credentials.conf -d URL
```
