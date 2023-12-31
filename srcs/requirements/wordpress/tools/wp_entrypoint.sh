#!/bin/sh

# Instalar wordpress-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp && \

# Baixar o wordpress
wp core download --allow-root --path=/data/wordpress

# Criar arquivo de configuração wp-config.php com dados do banco
wp config create --allow-root --path=/data/wordpress \
	--dbname=$DATABASE_NAME \
	--dbuser=$DATABASE_USER \
	--dbpass=$DATABASE_PASSWORD \
	--dbhost=$DATABASE_HOST \
	--dbprefix="wp_"

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
