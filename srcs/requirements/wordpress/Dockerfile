FROM alpine:3.17

COPY tools/wp_entrypoint.sh /usr/local/bin

RUN apk update && \
        apk add --no-cache wget mariadb-client \
        php81 php81-fpm php81-common php81-mysqli php81-phar

# Alterar a configuração de escuta do PHP-FPM para a porta 9000
RUN sed -i "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php81/php-fpm.d/www.conf

RUN mkdir -p /data/wordpress/

WORKDIR /data/wordpress

# Diretório onde o php-fpm irá armazenar o arquivo pid
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["wp_entrypoint.sh"]
