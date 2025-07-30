FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	nginx \
	openssl

# Erstelle ein Verzeichnis für die Zertifikate
RUN mkdir -p /etc/nginx/ssl

# Erstelle selbstsignierte Zertifikate mit OpenSSL
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=DE/ST=Berlin/L=Berlin/O=MeineFirma/OU=IT/CN=localhost"

COPY default /etc/nginx/sites-available/.

ENTRYPOINT ["nginx", "-g", "daemon off;"]
