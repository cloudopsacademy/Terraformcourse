#!/bin/bash
#!/bin/bash
if [ $UID -ne 0 ] ; then
echo " 403 Error !!.  Please run me as root"
exit
fi


echo "#################################################################################################################"
echo "#                                                                                                               #"
echo "# 		Welcome!! This script will  install php-backend eviroment  noninteractively                                   #"
echo "#                                                       							      #"
echo "#################################################################################################################"
echo -e "\n\n\n"
echo " 				Updating System files... "
echo -e "\n\n\n"

apt-get update -y

echo -e "\n\n\n"
echo " 			Done Updating... "
echo -e "\n\n\n";
echo " 			Installing Apache... "

# Install apache2

apt-get install -y apache2
apt-get install libapache2-mod-php7.0 -y
apt-get install libapache2-modsecurity -y


echo -e "\n\n\n"
echo "			Apache Installed	"
echo -e "\n\n\n"
echo  "			Installing PHP 7.1.."
echo -e "\n\n\n"
#install php7.1
apt-get install software-properties-common -y
add-apt-repository ppa:ondrej/php -y
apt-get update -y
apt-get -y install php7.0*
apt-get remove php7.0-snmp -y

echo -e "\n\n\n"
echo "			PHP 7.0 Installed.	"
echo -e "\n\n\n"
echo -e "\n\n\n"

echo "		Installing MySql Client...	"
echo -e "\n\n\n"
# install MySql


apt-get install -y mysql-client


echo -e "\n\n\n"
echo "		Mysql client installed"
echo -e "\n\n\n"
# Enable Various module's
echo "Enabling Various Modules"

a2enmod php7.0

a2enmod rewrite

a2enmod headers
a2enmod mod-security
a2enmod ssl
a2ensite default-ssl.conf

echo -e "\n\n\n"
echo "		Required Modules Enabled"
echo -e "\n\n\n"

# Increase post_max_size to 20 M
sed -i 's/post_max_size = 8M/post_max_size = 200M/'  /etc/php/7.0/apache2/php.ini
#Increase upload_max_size

sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/'  /etc/php/7.0/apache2/php.ini
#Increase KeepAliveTimeout
sed -i 's/KeepAliveTimeout 5/KeepAliveTimeout 60/' /etc/apache2/apache2.conf


systemctl restart apache2


# Create a directory for user

mkdir -p /var/www/html/ && cd /var/www/html

wget https://wordpress.org/latest.tar.gz
