FROM nginx:alpine

RUN mkdir -p /usr/share/nginx/html/images/

COPY docs/index.html docs/styles.css /usr/share/nginx/html/
COPY docs/images/* /usr/share/nginx/html/images/

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["sleep", "infinity"]

EXPOSE 443
