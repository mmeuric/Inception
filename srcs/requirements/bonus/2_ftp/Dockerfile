# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmeuric <mmeuric@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/12 23:20:16 by mmeuric           #+#    #+#              #
#    Updated: 2025/09/20 23:02:42 by mmeuric          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.21

RUN	apk update && apk upgrade && apk add --no-cache \
        vsftpd

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY conf/launchFTP.sh /

RUN chmod +x launchFTP.sh

ENTRYPOINT ["sh", "launchFTP.sh"]
