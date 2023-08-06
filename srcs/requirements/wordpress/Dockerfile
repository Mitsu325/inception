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

# Baixar o wordpress
RUN wp core download

# Criar arquivo de configuração wp-config.php com dados do banco
RUN wp config create --dbname=$DATABASE_NAME --dbuser=$DATABASE_USER \
	--dbpass=$DATABASE_PASSWORD --dbhost=$DATABASE_HOST

# Instalar o wordpress
RUN wp core install --url=$DOMAIN_NAME --title=$WP_TITLE \
	--admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_EMAIL

# Criar usuário
RUN wp user create $WP_USER_NAME $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS

# Diretório onde o php-fpm irá armazenar o arquivo pid
RUN mkdir -p /run/php

EXPOSE 9000

CMD ["php-fpm81", "-F"]
