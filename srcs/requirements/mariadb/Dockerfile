FROM alpine:3.16

RUN	apk update
RUN apk upgrade
RUN apk add --no-cache mariadb mariadb-client

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY tools/entrypoint.sh /tmp/entrypoint.sh

CMD ["sh", "/tmp/entrypoint.sh"]
