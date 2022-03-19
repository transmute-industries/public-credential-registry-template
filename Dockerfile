FROM node:14.15.3 as build

COPY sayHello.sh /sayHello.sh
RUN chmod +x /sayHello.sh
CMD ["/sayHello.sh"]
