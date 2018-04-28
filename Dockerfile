FROM php:7.2-fpm

# php-ext
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libicu-dev \
    libpng-dev \
    g++
RUN set -xe \
 && docker-php-ext-configure bcmath --enable-bcmath \
 && docker-php-ext-configure intl --enable-intl \
 && docker-php-ext-install \
    bcmath \
    intl

# PGSQL
RUN apt-get update && apt-get install -y \
    libpq-dev
RUN set -xe \
    && docker-php-ext-install \
    pdo_pgsql

# Redis
RUN pecl install -o -f redis \
 && rm -rf /tmp/pear \
 && docker-php-ext-enable redis

# Node
RUN apt-get update && apt-get install -y build-essential apt-utils gnupg gcc g++ make \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y nodejs

# Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get install yarn

# UTF8
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8 && \
    apt-get remove -y locales
ENV LANG C.UTF-8

# Git
RUN apt-get update && apt-get install -y git

# Zip
RUN apt-get update && apt-get install -y zip unzip
