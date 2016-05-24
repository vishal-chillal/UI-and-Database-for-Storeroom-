apt-get -y install apache2
apt-get -y install php5 libapache2-mod-php5
service apache2 restart
ln -s $(pwd) /var/www/html/
#chmod -R 777 $(pwd)
