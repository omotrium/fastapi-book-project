#!/bin/bash

# Update & Install Nginx
apt-get update && apt-get install -y nginx

# Remove default config if needed
rm -f /etc/nginx/sites-enabled/default

# Create Nginx Config
cat <<EOF > /etc/nginx/sites-available/app
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# Enable Nginx Config
ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/

# Restart Nginx
service nginx restart

# Start Python App
uvicorn main:app --host 0.0.0.0 --port $PORT
