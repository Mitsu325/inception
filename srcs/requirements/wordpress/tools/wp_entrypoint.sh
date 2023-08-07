#!/bin/sh

# Instalar o wordpress
wp core install --allow-root --path=/data/wordpress \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_NAME \
	--admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_EMAIL

# Criar usuário
wp user create $WP_USER_NAME $WP_USER_EMAIL \
	--role=author \
	--user_pass=$WP_USER_PASS --allow-root

php-fpm81 -F
