FROM ubuntu:trusty

VOLUME /build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -qq \
      wget \
      build-essential \
      libpq-dev \
      libssl-dev \
      openssl \
      libffi-dev \
      libncurses5-dev \
      libsqlite3-dev \
      libreadline-dev \
      zlib1g-dev

RUN rm -rf /var/lib/apt/lists/* /var/cache/*

ENV python_version "${python_version:-3.7.2}"

ENTRYPOINT exec sh -c "wget https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz && \
    tar -xvf Python-${python_version}.tgz && \
    cd Python-${python_version} && \
    ./configure --enable-optimizations --with-ensurepip=install --prefix=/opt && \
    make -j8 && \
    make altinstall && \
    tar -czf /build/python-${python_version}-ubuntu-trusty.tgz /opt"
