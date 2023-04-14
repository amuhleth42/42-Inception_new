FROM debian:buster

RUN apt update

RUN apt install -y nginx openssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/ssl/certs/nginx.crt \
       -keyout /etc/ssl/private/nginx.key \
       -subj "/C=FR/ST=Lausanne/L=Lausanne/O=42 School/OU=amuhleth/CN=amuhleth/"

COPY conf/default etc/nginx/sites-enabled/default

#CMD sleep infinity
CMD ["nginx", "-g", "daemon off;"]

