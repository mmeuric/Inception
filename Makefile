# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:19:09 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/22 19:39:01 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# =======================
#   Docker Management ⚡
# =======================

COMPOSE_FILE = srcs/docker-compose.yml
HOST_ENTRY   = 127.0.0.1 mmeuric.42.fr
DATA_DIR     = /home/${USER}/data

all: volumes
	@sudo apt-get -y install hostsed > /dev/null
	@sudo hostsed add $(HOST_ENTRY) > /dev/null
	@echo "\n\033[1;32m✅  Hôte $(HOST_ENTRY) ajouté à /etc/hosts\033[0m\n"
	@echo "🛠️  Construction et lancement des conteneurs..."
	@docker compose -f $(COMPOSE_FILE) up --build -d
	@echo "\033[1;32m🚀  Conteneurs opérationnels !\033[0m\n"

up: volumes
	@echo "\n\033[1;33m⬆️  Démarrage des conteneurs...\033[0m\n"
	@sudo hostsed add $(HOST_ENTRY) > /dev/null
	@echo "✅  $(HOST_ENTRY) ajouté à /etc/hosts"
	@docker compose -f $(COMPOSE_FILE) up -d
	@echo "\033[1;32m🚀  Conteneurs démarrés !\033[0m\n"

down:
	@echo "\n\033[1;33m⬇️  Arrêt et suppression des conteneurs...\033[0m\n"
	@sudo hostsed rm $(HOST_ENTRY) > /dev/null
	@echo "❌  $(HOST_ENTRY) retiré de /etc/hosts"
	@docker compose -f $(COMPOSE_FILE) down
	@echo "\033[1;32m🛑  Conteneurs arrêtés !\033[0m\n"

du: down up

stop:
	@echo "\n\033[1;33m⏸️  Pause des conteneurs...\033[0m\n"
	@docker compose -f $(COMPOSE_FILE) stop
	@echo "\033[1;32m🛑  Conteneurs stoppés !\033[0m\n"

start:
	@echo "\n\033[1;33m▶️  Relance des conteneurs...\033[0m\n"
	@docker compose -f $(COMPOSE_FILE) start
	@echo "\033[1;32m✅  Conteneurs relancés !\033[0m\n"

restart: stop start

re: down all

prod: down clear_volumes up

clean: down clear_volumes
	@echo "\n\033[1;33m🧹  Nettoyage complet Docker...\033[0m\n"
	@docker system prune -af
	@echo "\033[1;32m✨  Docker system purgé !\033[0m\n"

volumes:
	@echo "\n\033[1;33m📦  Création des volumes...\033[0m\n"
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/static_website_volume
	@echo "\033[1;32m✅  Volumes créés !\033[0m\n"

clear_volumes:
	@echo "\n\033[1;33m🗑️  Suppression des volumes...\033[0m\n"
	@sudo rm -rf $(DATA_DIR)/mariadb
	@sudo rm -rf $(DATA_DIR)/wordpress
	@sudo rm -rf $(DATA_DIR)/static_website_volume
	@echo "\033[1;32m✅  Volumes supprimés !\033[0m\n"

.PHONY: all up down du stop start restart re prod clean volumes clear_volumes
