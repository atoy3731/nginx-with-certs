#!/bin/ash

if [[ -z "$DOMAIN_NAME" ]]; then
    echo "ERROR: Missing 'DOMAIN_NAME' environment variable. Exiting."
    exit 1
fi

echo "Creating NGINX certificates for '$DOMAIN_NAME'.."
mkdir -p /etc/nginx/ssl
# sed -i -e "s/REPLACE_DOMAIN_NAME/$DOMAIN_NAME/g" /opt/openssl.cnf
openssl req -x509 -newkey rsa:4096 -passin pass:password -passout pass:password -keyout "/etc/nginx/ssl/tls-tmp.key" -out "/etc/nginx/ssl/tls.crt" -subj "/CN=$DOMAIN_NAME/O=example" -addext "subjectAltName = DNS:$DOMAIN_NAME" -addext "keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment" -sha256 -days 730
openssl rsa -passin pass:password -in "/etc/nginx/ssl/tls-tmp.key" -out "/etc/nginx/ssl/tls.key"
rm -f /etc/nginx/ssl/tls-tmp.key

echo "Updating 'default.conf' with '$DOMAIN_NAME'.."
sed -i -e "s/REPLACE_DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/conf.d/default.conf

echo "Running NGINX in foreground.."
nginx -g 'daemon off;'