daemon off;

# user www-data;  <-- remove this

pid /tmp/nginx.pid;

worker_processes 1;

pcre_jit on;

error_log /proc/1/fd/1 error;

events {
    worker_connections 512;
}

http {
    access_log off;
    client_max_body_size 4G;
    default_type application/octet-stream;
    keepalive_timeout 65;
    sendfile off;
    server_tokens off;
    tcp_nodelay on;
    tcp_nopush on;

    map $http_upgrade $connection_upgrade {
        default upgrade;
        '' close;
    }

    resolver 127.0.0.11 ipv6=off;

    server {
        listen 8099 default_server;

        root /dev/null;
        server_name _;

        location / {
            allow 172.30.0.0/16;
            deny all;

            set $target http://10.0.5.104:6052;

            proxy_pass $target;
            proxy_http_version 1.1;

            proxy_read_timeout 86400s;
            proxy_send_timeout 86400s;

            proxy_no_cache 1;
            proxy_cache_bypass 1;

            proxy_set_header Connection $connection_upgrade;
            proxy_set_header Host $http_host;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
}
