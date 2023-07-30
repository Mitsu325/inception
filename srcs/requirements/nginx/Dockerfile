FROM alpine:3.17

RUN apk update && \
        apk add --no-cache nginx openssl

# Gerar o self-signed ssl certificate
RUN openssl req \
	-x509 -nodes -days 365 \
	-newkey rsa:2048 -keyout /etc/ssl/private/server.key \
	-out /etc/ssl/certs/server.crt \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42/OU=Sao Paulo/CN=pmitsuko/emailAddress=pmitsuko@mail.com"

# Copiar o arquivo de configuração
COPY /conf/https.conf /etc/nginx/http.d/https.conf

# Expor a porta 443
EXPOSE 443

# Executar em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
