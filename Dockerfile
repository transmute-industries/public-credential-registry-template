FROM node:14.15.3 as build

LABEL com.example.image-specs="{\"Description\":\"A containerized foobar\",\"Usage\":\"docker run --rm example\\/foobar [args]\",\"License\":\"GPL\",\"Version\":\"0.0.1-beta\",\"aBoolean\":true,\"aNumber\":0.01234,\"aNestedArray\":[\"a\",\"b\",\"c\"]}"

COPY sayHello.sh /sayHello.sh
RUN chmod +x /sayHello.sh
CMD ["/sayHello.sh"]
