# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:21:26 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/20 23:01:44 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

# Basics container packages
RUN		apt-get -y update && \
    	apt-get -y install mariadb-server && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*
        
COPY conf/50-server.cnf /etc/mysql/my.cnf

COPY conf/mariadb_init_script.sh /

RUN chmod +x mariadb_init_script.sh

# # This expose command only serves as documentation
# # as the real exposing process happens to be in the docker-compose
EXPOSE 3306
        
ENTRYPOINT [ "bash", "mariadb_init_script.sh" ]