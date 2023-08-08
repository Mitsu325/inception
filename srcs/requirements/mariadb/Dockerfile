FROM alpine:3.17

ARG MYSQL_ROOT_PASSWORD DATABASE_NAME DATABASE_USER DATABASE_PASSWORD

RUN apk update && \
        apk add --no-cache mariadb mariadb-common mariadb-client


# Permitir conexão remota (outros containers)
RUN sed -i "s/skip-networking/skip-networking=0/g" etc/my.cnf.d/mariadb-server.cnf; \
        sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" etc/my.cnf.d/mariadb-server.cnf

RUN mkdir -p /var/run/mysqld; \
    chown -R mysql:mysql /var/run/mysqld;

RUN mkdir -p /var/lib/mysql; \
    chown -R mysql:mysql /var/lib/mysql; \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

RUN /usr/bin/mysqld_safe --datadir=/var/lib/mysql & sleep 5 && \
        echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" | mysql && \
        mysql -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;" && \
        mysql -e "CREATE USER '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD';" && \
        mysql -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%';" && \
        mysql -e "FLUSH PRIVILEGES;"

EXPOSE 3306

CMD ["mysqld_safe"]
