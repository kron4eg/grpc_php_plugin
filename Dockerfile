FROM ubuntu:xenial

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        libc-ares-dev \
        ca-certificates \
        build-essential \
        php7.0-dev \
        wget \
        git \
        zlib1g-dev \
    && wget https://github.com/google/protobuf/releases/download/v3.4.1/protobuf-php-3.4.1.tar.gz \
    && tar zxvf protobuf-php-3.4.1.tar.gz \
    && cd protobuf-3.4.1 \
    && ./configure \
    && make \
    && make install  \
    && ldconfig \
    && cd .. \
    && rm -rf protobuf-* \
    && git clone https://github.com/grpc/grpc.git --depth=1 \
    && cd grpc \
    && make grpc_php_plugin \
    && mv bins/opt/grpc_php_plugin /usr/local/bin/ \
    && cd .. \
    && rm -rf grpc \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*
