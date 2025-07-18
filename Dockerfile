FROM alpine:latest

RUN apk add nginx

RUN mkdir -p /usr/share/nginx/html/images/

COPY docs/index.html docs/styles.css /usr/share/nginx/html/
COPY docs/ico/192.webp /usr/share/nginx/html/favicon.webp
COPY docs/images/* /usr/share/nginx/html/images/

COPY nginx.conf /etc/nginx/nginx.conf

CMD sh -c "nginx & sleep infinity"

EXPOSE 443
