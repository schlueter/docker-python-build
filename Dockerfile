FROM ubuntu:trusty

VOLUME /build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -qq \
      wget \
      build-essential \
      libbz2-dev \
      libffi-dev \
      libncurses5-dev \
      libpq-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      openssl \
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
