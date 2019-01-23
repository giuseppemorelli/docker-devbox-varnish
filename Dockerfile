FROM debian:stretch

MAINTAINER Giuseppe Morelli <info@giuseppemorelli.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
    && apt-get -y install \
    varnish \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

COPY script /opt/script/

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      256M
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600 -T 0.0.0.0:6082 -S /etc/varnish/secret

EXPOSE 80
EXPOSE 6082

CMD ["/opt/script/entrypoint.sh"]