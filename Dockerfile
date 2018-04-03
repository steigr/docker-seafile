FROM ubuntu:18.04

# curl and ssl-certificates
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       curl ca-certificates

# Small Init
RUN curl -L https://github.com/krallin/tini/releases/download/v0.17.0/tini-amd64 \
    | install -m 0755 /dev/stdin /bin/tini

# Process supervisor
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       supervisor

# sqlite support
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       sqlite3

# python 2.7
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       python2.7 python-setuptools python-pil

# java
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       default-jre-headless

# language support
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  LANG= LC_ALL= apt-get install -y --no-install-recommends \
       locales \
 &&  LANG= LC_ALL= locale-gen ${LANG}

# LibreOffice for Office Integration
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       libreoffice libreoffice-script-provider-python

# PDF Integration
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       poppler-utils

# Office Integration for python 2.x
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  trap 'rm -r /var/lib/apt/lists/*' EXIT \
 &&  apt-get install -y --no-install-recommends \
       python-genshi python-cairo python-lxml python-setuptools \
 &&  easy_install uno

COPY dockerfiles/ /
ENTRYPOINT ["seafile"]