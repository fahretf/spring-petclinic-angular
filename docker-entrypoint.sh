#!/bin/sh

# Create config.js file with environment variables for the Angular app
echo "window.env = {" > /usr/share/nginx/html/config.js
echo "  REST_API_URL: '${REST_API_URL:-/petclinic/api/}'" >> /usr/share/nginx/html/config.js
echo "};" >> /usr/share/nginx/html/config.js

# Dynamically configure nginx proxy
BACKEND_URL=${BACKEND_URL:-http://petclinicbe:9966}
sed -i "s|__BACKEND_URL__|${BACKEND_URL}|g" /etc/nginx/conf.d/default.conf

# Start Nginx
exec nginx -g "daemon off;"