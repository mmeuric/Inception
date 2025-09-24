#!/bin/sh
echo "MariaDB seems to be running fine."

set -e

# Création du dossier WordPress
mkdir -p /var/www/html
cd /var/www/html

# Installer WP-CLI si absent
if [ ! -f "/usr/local/bin/wp" ]; then
    echo "Je télécharge WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    echo "WP-CLI installé !"
fi

# Télécharger WordPress si les fichiers de base n'existent pas
if [ ! -f "wp-load.php" ]; then
    echo "Téléchargement de WordPress..."
    wp core download --allow-root
fi

# Créer wp-config.php si absent
if [ ! -f "wp-config.php" ]; then
    echo "Création du fichier wp-config.php..."
    mv wp-config-sample.php wp-config.php

    sed -i "/define('DB_HOST'/a \
    define('WP_HOME', 'https://' . getenv('DOMAIN_NAME')); \
    define('WP_SITEURL', 'https://' . getenv('DOMAIN_NAME'));" wp-config.php

    sed -i -r "s|database_name_here|$MARIADB_DATABASE_NAME|1" wp-config.php
    sed -i -r "s|username_here|$MARIADB_ROOT_LOGIN|1" wp-config.php
    sed -i -r "s|password_here|$MARIADB_ROOT_PASSWORD|1" wp-config.php
    sed -i -r "s|localhost|mariadb:3306|1" wp-config.php
fi

# Ne réinstalle WordPress que si ce n'est pas déjà fait dans la base
if ! wp core is-installed --allow-root; then
    echo "Installation et configuration de WordPress..."
    wp core install \
        --url="https://$DOMAIN_NAME/" \
        --title="$WEBSITE_TITLE" \
        --admin_user=$WP_ADMIN_LOGIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root

    wp user create $WP_USER_LOGIN $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

    # Configurer Redis

    sed -i "/\/\* Add any custom values between this line and the \"stop editing\" line. \*\//a \
    define( 'WP_REDIS_HOST', 'redis' ); \
    define( 'WP_REDIS_PORT', 6379 ); \
    define( 'WP_CACHE', true ); \
    define( 'WP_CACHE_KEY_SALT', getenv('DOMAIN_NAME') ?: 'default_salt'); \
    define( 'WP_REDIS_TIMEOUT', 5 ); \
    define( 'WP_REDIS_READ_TIMEOUT', 5 ); \
    define( 'WP_REDIS_CLIENT', 'phpredis' );" wp-config.php


    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
    wp redis enable --allow-root

    echo "WordPress installé avec succès !"
else
    echo "WordPress est déjà installé, aucune réinstallation."
fi

# Vérifier que PHP-FPM peut tourner
mkdir -p /run/php

# Lancer PHP-FPM
exec /usr/sbin/php-fpm8.2 -F
