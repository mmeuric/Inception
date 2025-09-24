# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:19:55 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/20 23:01:44 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

RUN		apt-get -y update && \
		apt-get install -y redis-server redis-tools && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]