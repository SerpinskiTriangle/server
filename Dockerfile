FROM alpine:latest

RUN apk add busybox-extras stunnel

RUN mkdir -p /var/www
RUN mkdir -p /var/ww/images

COPY docs/index.html docs/styles.css /var/www/
COPY docs/images/* /var/www/images/

COPY stunnel.conf /etc/stunnel

EXPOSE 443

CMD sh -c "httpd -f -p 8080 -h /var/www & stunnel /etc/stunnel/stunnel.conf & wait -n"
