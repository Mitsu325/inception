FROM alpine:3.17

RUN apk update && apk add mariadb mariadb-client && apk add openrc --no-cache
RUN mkdir -p /run/openrc && \
	touch /run/openrc/softlevel
RUN openrc

# Permitir conexão remota (outros containers)
RUN echo "[mysqld] \n\
skip-networking=0 \n\
skip-bind-address" >> /etc/mysql/my.cnf

RUN /etc/init.d/mariadb setup

RUN rc-service mariadb start && \
	mariadb -u root -e \
	"CREATE DATABASE IF NOT EXISTS wordpress_db; \
	CREATE USER 'wpmitsuko'@'%' IDENTIFIED BY 'wpass!249'; \
	GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wpmitsuko'@'%'; \
	FLUSH PRIVILEGES;" && \
	rc-service mariadb stop

CMD ["mysqld_safe"]
