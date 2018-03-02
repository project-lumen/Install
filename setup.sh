#!/bin/bash
# ------------------------------------------------------------------
# [Jeremie Sophikitis, Adrien Fevre, Victor Anton]
# Setup.sh
# Configuration d'une vagrant Lumen Apache2 MongoDB
# -----------------------------------------------------------------
echo "
 ____________________________________
|                                    |
|        UPDATE / UPGRADE            |
 ____________________________________
"
# UPDATE UPGRADE & INSTALL UNZIP

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install unzip


echo "
 ____________________________________
|                                    |
|               PHP                  |
 ____________________________________
"
echo " *** ADD PHP7.2 *** "
sudo add-apt-repository ppa:ondrej/php

echo " *** UPDATE *** "
sudo apt-get update -y

echo " *** INSTALL PHP 7.2 *** "
sudo apt-get install php7.2 -y

echo " *** INSTALL PHP 7.2 PACKAGE  *** "
sudo apt-get install php7.2-zip -y

echo " *** INSTALL APACHE 2 / LIBAPACHE 2 *** "
sudo apt-get install -y apache2 libapache2-mod-php7.2

# INSTALL EXTENSIONS PHP

echo " *** PHP XML *** "
sudo apt-get install php7.2-xml -y

echo " *** INSTALL PHP 7.2 COMMON *** "
sudo apt-get install php7.2-common -y

echo " *** INSTALL PHP 7.2 MBSTRING *** "
sudo apt-get install php7.2-mbstring -y

echo " *** INSTALL PHP OPENSSL *** "
sudo apt-get install openssl -y

echo " *** INSTALL PHP MONGO *** "
sudo apt-get install php-mongodb -y



 echo "
  ____________________________________
 |                                    |
 |              MONGO DB              |
  ____________________________________
 "
 echo " *** ADD MONGO DB *** "
 sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

 echo " *** UPDATE *** "
 sudo apt-get update

 echo " *** INSTALL MONGO DB *** "
 sudo apt-get install -y mongodb-org


echo "
 ____________________________________
|                                    |
|              COMPOSER              |
 ____________________________________
"

echo " *** INSTALL ADD COMPOSER  *** "
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"


echo " *** COMPOSER SETUP *** "
php composer-setup.php
php -r "unlink('composer-setup.php');"

echo " *** DEPLACE COMPOSER *** "
sudo mv composer.phar /usr/local/bin/composer

echo " *** DISPLAY VERSION COMPOSER  *** "
composer -V

echo "
 ____________________________________
|                                    |
|           Init projet              |
 ____________________________________
"
cd /var/www/html
# Mise a jour de composer
composer update -vvv

#Creation d'un dossier temporaire pour l'archive ZIP
mkdir buffer
cd buffer

# Telechargement de l'archive
wget http://jeremie-soffichiti.fr/assets.zip

# Extraction de l'archive dans le dossier temporaire
unzip assets.zip

cd assets

# Deplace les fichiers dezippés dans leur dossier specifique
 mv -f vendor ../../
 mv -f .htaccess ../../public
 mv -f .env ../../
 mv -f .env.example ../../
 mv -f .gitignore ../../
 mv -f apache2.conf /etc/apache2/apache2.conf
 mv -f 000-default.conf /etc/apache2/sites-enables/000-default.conf

# On active le mode Rewrite
sudo a2enmod rewrite
# Recharge la config d'apache
sudo /etc/init.d/apache2 reload
# Redemarre apache2
sudo service apache2 restart


 cd ../../
 # Supprime le dossier temporaire
 rm -rf buffer
