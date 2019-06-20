From ubuntu:18.04

RUN apt-get update

RUN apt-get install -y apache2 apache2-utils

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN echo '<IfModule mod_dir.c>\n\t\tDirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm\n</IfModule>'

RUN sed -i "13 i \ \n\t# Added automatically using dockerfile\n\t<Directory /var/www/html>\n\t\tOptions Indexes FollowSymLinks MultiViews\n\t\tAllowOverride All\n\t\tRequire all granted\n\t</Directory>\n" /etc/apache2/sites-available/000-default.conf
RUN sed -i '30 a \ \n\t# Added automatically using dockerfile\n\t<IfModule mod_dir.c>\n\t\tDirectoryIndex index.php index.pl index.cgi index.html index.xhtml index.htm\t\n\t</IfModule>\n' /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

RUN service apache2 restart

RUN apt-get -y install --fix-missing \
	apt-utils \
	build-essential \
	curl \
	openssl \
	libcurl4-openssl-dev \
	pkg-config \
	libssl-dev \
	zip \
	unzip \
	git \
	libxml2 \
	zlib1g-dev \
	libxml2-dev

RUN apt-get install -y software-properties-common

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y php7.3 php7.3-cli php7.3-common

RUN apt-get install -y php-pear php7.3-curl php7.3-dev php7.3-gd php7.3-mbstring php7.3-zip php7.3-mysql php7.3-xml php7.3-fpm libapache2-mod-php7.3 php7.3-imagick php7.3-recode php7.3-tidy php7.3-xmlrpc php7.3-intl

RUN pecl uninstall mongodb && pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/7.3/cli/php.ini
RUN echo "extension=mongodb.so" >> /etc/php/7.3/apache2/php.ini

RUN pecl install grpc
RUN echo "extension=grpc.so" >> /etc/php/7.3/cli/php.ini
RUN echo "extension=grpc.so" >> /etc/php/7.3/apache2/php.ini

RUN apt-get install -y php7.3-pdo php7.3-mysqli php7.3-bcmath php7.3-soap php7.3-json

RUN a2enmod proxy_fcgi setenvif

RUN a2enconf php7.3-fpm

RUN service apache2 restart

RUN apt-get install -y sudo

RUN echo "root:ser_123" | chpasswd

RUN groupadd dev
RUN useradd -d /home/dev -u 1000 -g dev dev
RUN echo 'dev:ser_123' | chpasswd
RUN usermod -aG sudo dev
RUN mkdir /home/dev
USER dev
WORKDIR /home/dev
