echo "wp db name: $WP_DB_NAME"
echo "wp db usr: $WP_DB_USR"
echo "wp db pwd: $WP_DB_PWD"
echo "mariadb root pwd: $MARIADB_ROOT_PWD"


if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PWD';
CREATE DATABASE $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$WP_DB_USR'@'%' IDENTIFIED by '$WP_DB_PWD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USR'@'%';
FLUSH PRIVILEGES;
EOF
	/usr/bin/mysqld --user=mysql --bootstrap < $tfile

	rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --console
