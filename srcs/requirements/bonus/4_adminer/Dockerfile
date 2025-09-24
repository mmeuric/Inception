# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:20:47 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/24 19:03:45 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

RUN		apt-get -y update && \
    	apt-get -y install wget php php-mysql && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

# Bind 
RUN mkdir -p /var/www/html

RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

EXPOSE 8090

CMD ["php", "-S", "0.0.0.0:8090", "-t", "/var/www/html"]
