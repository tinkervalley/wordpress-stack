FROM wordpress:php8.1-fpm-alpine

COPY phpredis-5.3.7.tar.gz /tmp/redis.tar.gz

ENV PHPREDIS_VERSION=5.3.7

RUN apk update \
  && apk add git

RUN docker-php-source extract \
  && tar xfz /tmp/redis.tar.gz \
  && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
  && docker-php-ext-install redis
