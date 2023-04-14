FROM debian:buster

RUN apt update

RUN apt install -y mariadb-server mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init.sh /run/init.sh

RUN bash /run/init.sh

CMD mysqld_safe
