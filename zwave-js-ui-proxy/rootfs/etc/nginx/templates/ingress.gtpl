server {
    listen 8091 default_server;

    include /etc/nginx/includes/server_params.conf;

    location / {
        allow   172.30.32.2;
        deny    all;

        proxy_pass http://backend;
        proxy_set_header X-Ingress-Path {{ .entry }};
		proxy_set_header X-External-Path $http_x_ingress_path;
        include /etc/nginx/includes/proxy_params.conf;
    }
}