FROM alpine:3.17

RUN apk update && \
        apk add --no-cache nginx openssl

# Gerar o self-signed ssl certificate
RUN openssl req \
	-x509 -nodes -days 365 \
	-newkey rsa:2048 -keyout /etc/ssl/private/localhost.key \
	-out /etc/ssl/certs/localhost.crt \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42SP/OU=pmitsuko/CN=pmitsuko"

# Copiar o arquivo de configuração
COPY /conf/https.conf /etc/nginx/conf.d

# Expor a porta 443
EXPOSE 443

# Executar em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
