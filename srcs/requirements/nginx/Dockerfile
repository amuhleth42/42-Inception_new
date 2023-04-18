FROM	alpine:3.16

RUN		apk update

RUN		apk add --no-cache nginx openssl

COPY	conf/nginx.conf /etc/nginx/http.d/default.conf

RUN mkdir /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/amuhleth.crt \
       -keyout /etc/nginx/ssl/amuhleth.key \
       -subj "/C=CH/ST=VD/L=Lausanne/O=42 School/OU=student/CN=amuhleth/"

CMD	["nginx", "-g", "daemon off;"]
