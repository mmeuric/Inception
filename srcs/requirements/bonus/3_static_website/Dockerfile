# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:20:32 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/22 23:44:54 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# **************************************************************************** #
#                                                                              #
#    Dockerfile pour site statique                                             #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

# Installer Apache
RUN apt-get update -y && \
    apt-get install -y apache2 curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Créer le dossier pour le site
RUN mkdir -p /var/www/static_website

# Copier le fichier index.html directement
COPY index.html /var/www/static_website/index.html

# Exposer le port HTTP
EXPOSE 80

# Définir le répertoire par défaut pour Apache
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/static_website|' /etc/apache2/sites-available/000-default.conf

# Lancer Apache en avant-plan
CMD ["apache2ctl", "-D", "FOREGROUND"]


