# Variablen
DOCKER_COMPOSE = docker-compose
COMPOSE_FILE = srcs/docker-compose.yml
MYSQL_DIR := /home/$(USER)/data/mysql
WORDPRESS_DIR := /home/$(USER)/data/wordpress
NGINX_DIR := /home/$(USER)/data/requirements/nginx/ssl

USER_NAME := $(shell whoami)


all: set_up_volume generate_ssl_certificates up

set_up_volume:
	@echo "Erstelle Verzeichnisse für MariaDB und WordPress..."
	@mkdir -p $(MYSQL_DIR)
	@mkdir -p $(WORDPRESS_DIR)
	@mkdir -p $(NGINX_DIR)
	@echo "Verzeichnisse erstellt!"

generate_ssl_certificates:
	@echo "Erstelle SSL-Zertifikate für NGINX..."
	@openssl req -newkey rsa:2048 -nodes -keyout $(NGINX_DIR)/server.key -out $(NGINX_DIR)/server.csr -subj "/CN=localhost"
	@openssl x509 -req -days 365 -in $(NGINX_DIR)/server.csr -signkey $(NGINX_DIR)/server.key -out $(NGINX_DIR)/server.crt
	@echo "SSL-Zertifikate erstellt!"



# Standardbefehl: Container starten
up:
	@export USER_NAME=$(USER_NAME)
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build -d



# Container stoppen
down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

# Logs anzeigen
logs:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

# Container bauen (z. B. nach Änderungen am Dockerfile)
build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

# Alle Container, Netzwerke und Volumes entfernen (vorsichtig verwenden!)
clean:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v

# Hilfe anzeigen
help:
	@echo "Verfügbare Befehle:"
	@echo "  make up        - Starte Docker Compose"
	@echo "  make down      - Stoppe und entferne Container"
	@echo "  make logs      - Zeige Logs an"
	@echo "  make restart   - Starte einen Dienst neu"
	@echo "  make build     - Baue die Container neu"
	@echo "  make clean     - Entferne Container, Netzwerke und Volumes"