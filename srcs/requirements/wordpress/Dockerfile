FROM alpine:3.16

RUN apk update
RUN apk upgrade
RUN apk add --no-cache php php-fpm php-phar \
			php-json php-curl php-mysqli \
			php-iconv php-common php-cli \
			php-opcache php-gd php-zlib \
			wget tar mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

COPY conf/www.conf /etc/php8/php-fpm.d/www.conf

RUN mkdir /run/php

RUN adduser -S nginx && addgroup -S nginx

COPY tools/entrypoint.sh /run

RUN chmod +x /run/entrypoint.sh

WORKDIR /var/www/wordpress

CMD ["sh", "/run/entrypoint.sh"]
