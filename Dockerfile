FROM bitnami/minideb

ENV HOSTFILE=/target/etc/hostfile

RUN apt-get update \
	&& apt-get -y install python3 python3-pip \
	&& rm -Rf /var/lib/apt/lists/* \
	&& pip3 install slack-webhook

COPY check.sh slack-message /usr/local/bin/

CMD check.sh
