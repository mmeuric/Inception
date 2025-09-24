# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:22:26 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/21 01:41:12 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

# Installation des dépendances PHP et utilitaires
RUN apt-get update -y && \
    apt-get install -y \
        curl \
        sudo \
        php8.2 \
        php8.2-fpm \
        php8.2-mysql \
        php8.2-gd \
        php8.2-xml \
        php8.2-curl \
        php8.2-mbstring \
        php8.2-zip \
        mariadb-client \
        php-redis \
        ftp \
        jq \
		net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Création des dossiers nécessaires pour WordPress et PHP-FPM
RUN mkdir -p /var/www/html /run/php

# Copy the conf file
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Copie et permission du script de lancement
COPY conf/launchWP.sh /usr/local/bin/launchWP.sh
RUN chmod +x /usr/local/bin/launchWP.sh

# Définition du point d'entrée
ENTRYPOINT ["/bin/sh", "/usr/local/bin/launchWP.sh"]

# Exposition du port PHP-FPM
EXPOSE 9000
