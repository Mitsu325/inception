FROM alpine:3.17

ARG DATABASE_NAME DATABASE_USER DATABASE_PASSWORD DATABASE_HOST

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
	sed -i "s/database_name_here/$DATABASE_NAME/g" wp-config.php && \
	sed -i "s/username_here/$DATABASE_USER/g" wp-config.php && \
	sed -i "s/password_here/$DATABASE_PASSWORD/g" wp-config.php && \
	sed -i "s/localhost/$DATABASE_HOST/g" wp-config.php

# Diretório onde o php-fpm irá armazenar o arquivo pid
RUN mkdir -p /run/php

EXPOSE 9000

CMD ["php-fpm81", "-F"]
