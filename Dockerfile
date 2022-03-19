FROM node:14.15.3 as build

LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.documentation="https://example.com/documentation"

COPY sayHello.sh /sayHello.sh
RUN chmod +x /sayHello.sh
CMD ["/sayHello.sh"]
