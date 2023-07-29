FROM alpine:3.17

RUN apk update && \
        apk add --no-cache mariadb mariadb-common mariadb-client openrc
RUN mkdir -p /run/openrc && \
        touch /run/openrc/softlevel
RUN openrc

# Permitir conexão remota (outros containers)
RUN sed -i "s/skip-networking/skip-networking=0/g" etc/my.cnf.d/mariadb-server.cnf; \
        sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" etc/my.cnf.d/mariadb-server.cnf

RUN /etc/init.d/mariadb setup

RUN rc-service mariadb start && \
        mysql -u root -e \
        "CREATE DATABASE IF NOT EXISTS wordpress_db; \
        CREATE USER 'wuser'@'%' IDENTIFIED BY 'wpass'; \
        GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wuser'@'%'; \
        FLUSH PRIVILEGES;" && \
        rc-service mariadb restart && \
        rc-service mariadb stop

CMD ["mysqld_safe"]
