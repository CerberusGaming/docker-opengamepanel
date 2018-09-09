FROM php:7.2-apache

ENV MYSQL_HOST db
ENV MYSQL_USER ogp
ENV MYSQL_PASSWORD ogp
ENV MYSQL_DATABASE ogp

ENV EXTRAS_REPO none
ENV APACHE_DOCUMENT_ROOT "/var/www/html"


RUN apt-get update \
    && apt-get -y install git libxml2-dev zlib1g-dev mysql-client \
    && docker-php-ext-install bcmath mysqli xmlrpc zip
RUN a2enmod rewrite

RUN git clone https://github.com/OpenGamePanel/OGP-Website.git .

COPY config.inc.php /var/www/html/includes/
COPY docker-ogp-entrypoint /usr/local/bin/
RUN chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP $APACHE_DOCUMENT_ROOT \
    && chmod a+x /usr/local/bin/docker-ogp-entrypoint


ENTRYPOINT ["docker-ogp-entrypoint"]
WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
