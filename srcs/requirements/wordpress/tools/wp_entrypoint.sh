#!/bin/sh

# Baixar o wordpress
RUN wp core download

# Criar arquivo de configuração wp-config.php com dados do banco
wp config create --dbname=$DATABASE_NAME --dbuser=$DATABASE_USER \
	--dbpass=$DATABASE_PASSWORD --dbhost=$DATABASE_HOST

# Instalar o wordpress
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE \
	--admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_EMAIL

# Criar usuário
wp user create $WP_USER_NAME $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS

php-fpm81 -F
