#! /bin/sh

# Allows the script to exit if any of the commands fails
set -e

# Validate ENV variables before going further
if [ -z "$MARIADB_DATABASE_NAME" ] || [ -z "$MARIADB_ROOT_PASSWORD" ] || [ -z "$MARIADB_USER_LOGIN" ] || [ -z "$MARIADB_USER_PASSWORD" ]; then
    echo "One or more required environment variables are missing:"
    echo "MARIADB_DATABASE_NAME, MARIADB_ROOT_PASSWORD, MARIADB_USER_LOGIN, MARIADB_USER_PASSWORD"
    exit 1
fi

# If the database does not exists, initialize the database
if [ ! -f "/var/lib/mysql/wp_inception_database" ]; then

	# Launching mysql as a background task
	mysqld_safe &

	echo "Starting MariaDB daemon process: $MARIADB_DATABASE_NAME ..."
	sleep 10

	echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';" > init_db.sql # DONE
	echo "ALTER USER 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';" >> init_db.sql # DONE
	echo "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE_NAME}\`;" >> init_db.sql # DONE
	echo "CREATE USER IF NOT EXISTS '${MARIADB_USER_LOGIN}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';" >> init_db.sql # DONE
	echo "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE_NAME}\`.* TO \`${MARIADB_USER_LOGIN}\`@'%';" >> init_db.sql # DONE
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" >> init_db.sql # DONE
	echo "FLUSH PRIVILEGES;" >> init_db.sql

	echo "Initializing database..."

	mariadb < init_db.sql

	# Checks if the database init went well
	if [ $? -eq 0 ]; then
		echo "Database ${MARIADB_DATABASE_NAME} created successfully."
	else
		echo "Failed to create database."
		exit 1
	fi

	rm init_db.sql

	# Kill current instance of mysqld_safe to avoid getting two instances of mysql running in the same container
	killall mysqld_safe

	#
	wait

	echo -e "\033[0;32m***** MariaDB Database SUCCESSFULLY created *****\033[0m"
else
	echo -e "\033[0;33m***** MariaDB Database ALREADY created *****\033[0m"
fi

# Start MariaDB in the foreground to keep the container alive
# The exec command replaces the shell process (or the current script) with the mysqld process
exec mysqld
