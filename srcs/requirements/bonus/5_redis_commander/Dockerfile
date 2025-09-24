# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:21:08 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/20 23:01:44 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-12}

RUN		apt-get -y update && \
    	apt-get -y install npm && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

RUN npm install -g redis-commander

ENTRYPOINT ["redis-commander"]
# ENTRYPOINT ["redis-commander", "--config", "/root/.redis-commander"]

# ENTRYPOINT ["redis-commander", "--nl", "--redis-hosts", "redis_wp:redis:6379:0"]

# ENTRYPOINT ["redis-commander", "-1-host", "redis", "--port", "6579", "--is-cluster"]
