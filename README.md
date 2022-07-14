# Nginx With Certs

This will:

1. Auto-gen self-signed certificates for a specified domain.
2. Serve HTTPS Nginx for that domain.

## How to run:

Run a container like so:
```
docker run -e "DOMAIN_NAME=foo.example.com" -p 8443:8443 -d --name nginx-with-certs atoy3731/nginx-with-certs:latest
```