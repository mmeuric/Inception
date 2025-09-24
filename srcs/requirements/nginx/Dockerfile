# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:21:46 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/20 23:01:44 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

# Basics container packages
RUN		apt-get update -y && \
		apt-get install -y nginx openssl curl && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/nginx
		
# Copy the conf file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Give authorization on the root
RUN chmod 755 /var/www/html

# Give authorization on the main user
RUN chown -R www-data:www-data /var/www/html

# Static_website bonuses
# RUN mkdir -p /var/www/static_website
# RUN chown -R www-data:www-data /var/www/static_website

# Build Path for certificate
ARG PATH_NGINX_CERTIFICATE
RUN mkdir -p ${PATH_NGINX_CERTIFICATE}

# Build Path for TSL key
ARG PATH_NGINX_TSL_KEY
RUN mkdir -p ${PATH_NGINX_TSL_KEY}

# Creating the self-signed certificate
RUN		openssl req -x509 \
        -nodes \
        -out ${PATH_NGINX_CERTIFICATE}/inception.crt \
        -keyout ${PATH_NGINX_TSL_KEY}/inception.key \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mmeuric.42.fr/UID=mmeuric"

# Expose DockerFile directive only serves a documentation process
# The real port-binding happens in the docker-compose
EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]

LABEL maintainer="mmeuric@student.42.fr" \
      version="1.0" \
      description="Image Nginx pour le projet Inception"
