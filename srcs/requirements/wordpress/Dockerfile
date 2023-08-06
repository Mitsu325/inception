FROM alpine:3.17

ARG DATABASE_NAME DATABASE_USER DATABASE_PASSWORD DATABASE_HOST
ARG DOMAIN_NAME WP_TITLE WP_ADMIN_NAME WP_ADMIN_PASS WP_ADMIN_EMAIL
ARG WP_USER_NAME WP_USER_PASS WP_USER_EMAIL

RUN apk update && \
        apk add --no-cache wget mariadb-client \
        php81 php81-fpm php81-common php81-mysqli php81-phar

# Alterar a configuração de escuta do PHP-FPM para a porta 9000
RUN sed -i "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php81/php-fpm.d/www.conf

# Instalar wordpress-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir -p /data/wordpress/

WORKDIR /data/wordpress

# Diretório onde o php-fpm irá armazenar o arquivo pid
RUN mkdir -p /run/php

EXPOSE 9000

COPY tools/wp_entrypoint.sh /tmp/wp_entrypoint.sh
ENTRYPOINT ["sh", "/tmp/wp_entrypoint.sh"]
