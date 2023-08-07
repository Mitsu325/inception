FROM alpine:3.17

ARG DATABASE_NAME DATABASE_USER DATABASE_PASSWORD DATABASE_HOST
ARG DOMAIN_NAME WP_TITLE WP_ADMIN_NAME WP_ADMIN_PASS WP_ADMIN_EMAIL
ARG WP_USER_NAME WP_USER_PASS WP_USER_EMAIL

COPY tools/wp_entrypoint.sh /tmp/wp_entrypoint.sh
RUN chmod +x /tmp/wp_entrypoint.sh

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

# Baixar o wordpress
RUN wp core download --allow-root

# Configurar wordpress para usar o banco mariadb
RUN cp wp-config-sample.php wp-config.php && \
	sed -i "s/database_name_here/$DATABASE_NAME/g" wp-config.php && \
	sed -i "s/username_here/$DATABASE_USER/g" wp-config.php && \
	sed -i "s/password_here/$DATABASE_PASSWORD/g" wp-config.php && \
	sed -i "s/localhost/$DATABASE_HOST/g" wp-config.php

# Diretório onde o php-fpm irá armazenar o arquivo pid
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["ash", "-f", "/tmp/wp_entrypoint.sh"]
