service apache2 restart
ln -s $(pwd)/front_end /var/www/html/
ln -s $(pwd)/back_end/first.py /var/www/cgi-bin/
service apache2 restart
