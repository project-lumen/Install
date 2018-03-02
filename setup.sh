
echo "
 ____________________________________
|                                    |
|        UPDATE / UPGRADE            |
 ____________________________________
"
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
echo " *** XML *** "

sudo apt-get install php7.2-xml -y



    echo -e"
\033[45m INSTALLATION EXTENSIONS PHP \033[0m"

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
|              LUMEN                 |
 ____________________________________
"
cd /var/www/html
composer update -vvv

mkdir buffer
cd buffer
wget http://jeremie-soffichiti.fr/assets.zip

unzip assets.zip

cd assets

 mv vendor ../../
 mv .htaccess ../../public
 mv .env ../../
 mv .env.example ../../
 mv .gitignore ../../
 mv apache2.conf /etc/apache2/apache2.conf

 cd ../../
 sudo rm -rf buffer
