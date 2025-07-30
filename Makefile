
# Variablen
DOCKER_COMPOSE = docker compose
COMPOSE_FILE = srcs/docker-compose.yml
MYSQL_DIR := /home/$(USER)/data/db
WORDPRESS_CON := /home/$(USER)/data/web/wp-content
WORDPRESS_DIR := /home/$(USER)/data/web
NGINX_DIR := /home/$(USER)/data/requirements/nginx

USER_NAME := $(USER)


all: set_up_volume set_up_hosts up

set_up_hosts:
	@if ! grep -q "kkuhn.42.fr" /etc/hosts; then \
		echo "127.0.0.1 kkuhn.42.fr" | sudo tee -a /etc/hosts; \
	else \
		echo "kkuhn.42.fr already in /etc/hosts"; \
	fi

set_up_volume:
	@echo "Erstelle Verzeichnisse für MariaDB und WordPress..."
	@echo $(USER_NAME)
	@mkdir -p $(MYSQL_DIR)
	@mkdir -p $(WORDPRESS_DIR)
	@mkdir -p $(WORDPRESS_CON)
	@mkdir -p $(NGINX_DIR)
	@echo "Verzeichnisse erstellt!"


# Standardbefehl: Container starten
up:
	@export USER_NAME=$(USER_NAME) && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build -d



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
