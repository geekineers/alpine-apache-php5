FROM alpine:latest

MAINTAINER geekineers <developers@8layertech.com>

RUN apk update && apk upgrade && \
    apk add --no-cache curl openssl && \
    apk add --no-cache php5 php5-apache2 php5-openssl && \
    apk add --no-cache php5-fpm php5-cli php5-mysql php5-pgsql php5-sqlite3 php5-phar && \
    apk add --no-cache php5-apcu php5-intl php5-imagick php5-mcrypt php5-json php5-gd php5-curl && \
    cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN sed -i 's/AllowOverride none/AllowOverride All/g' /etc/apache2/httpd.conf && \
    sed -i 's/\#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf

COPY httpd-foreground /usr/local/bin/

RUN chmod 755 /usr/local/bin/httpd-foreground

EXPOSE 80 443

CMD ["httpd-foreground"]