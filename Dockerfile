FROM php:7.0

MAINTAINER Zoran Antolovic <zoran.antolovic.os@gmail.com>

# We need to install dependencies only for Docker
RUN [[ ! -e /.dockerenv ]] && exit 0

RUN set -xe

# Install git (the php image doesn't have it) which is required by composer
RUN apt-get update -yqq
RUN apt-get install git gzip unzip zlib1g-dev libxml2-dev -yqq

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install mysql driver
# Here you can install any other extension that you need
RUN docker-php-ext-install pdo_mysql zip xml pcntl
RUN pecl install xdebug && docker-php-ext-enable xdebug

