FROM alpine:latest
RUN apk add tor
COPY ./torrc /etc/tor/torrc
USER tor
CMD tor -f /etc/tor/torrc
EXPOSE 9150
EXPOSE 9050
VOLUME /var/lib/tor