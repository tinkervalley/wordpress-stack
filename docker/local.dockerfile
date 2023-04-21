FROM wordpress:php8.1-fpm-alpine

COPY docker/phpredis-5.3.7.tar.gz /tmp/
COPY docker/vips-1.0.13.tgz /tmp/

RUN apk update \
  && apk add git
  
RUN apk add --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community --repository http://dl-3.alpinelinux.org/alpine/edge/main vips-dev

RUN docker-php-source extract \
  && tar xfz /tmp/phpredis-5.3.7.tar.gz \
  && mv phpredis-5.3.7 /usr/src/php/ext/redis \
  && docker-php-ext-install redis
  
RUN docker-php-source extract \
  && tar xf /tmp/vips-1.0.13.tgz \
  && mv vips-1.0.13 /usr/src/php/ext/vips \
  && docker-php-ext-install vips
