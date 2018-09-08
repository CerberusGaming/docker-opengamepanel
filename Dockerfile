FROM php:apache

RUN apt-get update \
    && apt-get -y install git libxml2-dev zlib1g-dev \
    && docker-php-ext-install bcmath mysqli xmlrpc zip
RUN a2enmod rewrite
