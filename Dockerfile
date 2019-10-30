FROM alpine

ENV HOSTFILE=/target/etc/hostfile

CMD apk --no-cache add curl

COPY slack-message
