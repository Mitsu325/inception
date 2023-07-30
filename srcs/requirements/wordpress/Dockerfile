FROM alpine:3.17

RUN apk update && \
        apk add --no-cache wget mariadb-client \
        php81-fpm php81-common php81-mysqli

# Alterar a configuração de escuta do PHP-FPM para a porta 9000
RUN sed -i "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php81/php-fpm.d/www.conf

# Instalar wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	mkdir -p /data/wordpress/ && \
	mv wordpress/* /data/wordpress && \
	rm -rf wordpress latest.tar.gz

WORKDIR /data/wordpress

# Configurar wordpress para usar o banco mariadb
RUN cp wp-config-sample.php wp-config.php && \
	sed -i "s/database_name_here/wordpress_db/g" wp-config.php && \
	sed -i "s/username_here/wuser/g" wp-config.php && \
	sed -i "s/password_here/wpass/g" wp-config.php && \
	sed -i "s/localhost/mariadb/g" wp-config.php

# Diretório onde o php-fpm irá armazenar o arquivo pid
RUN mkdir -p /run/php

EXPOSE 9000

CMD ["php-fpm81", "-F"]
