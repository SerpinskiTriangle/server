FROM alpine:latest

RUN apk add nginx

RUN mkdir -p /usr/share/nginx/html/images/
RUN mkdir -p /usr/share/nginx/html/src/

COPY docs/index.html docs/styles.css /usr/share/nginx/html/
COPY docs/ico/192.webp /usr/share/nginx/html/favicon.webp
COPY docs/images/* /usr/share/nginx/html/images/
COPY docs/src/* /usr/share/nginx/html/src/

COPY nginx.conf /etc/nginx/nginx.conf

CMD sh -c "nginx & sleep infinity"

EXPOSE 443
