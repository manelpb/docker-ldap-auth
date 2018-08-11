FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	build-base \
	libffi-dev \
	openldap-dev \
	python2-dev && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	libffi \
	libldap \
	py2-pip \
	python2 && \
 pip install -U --no-cache-dir \
	cryptography \
	python-ldap && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8888 9000
