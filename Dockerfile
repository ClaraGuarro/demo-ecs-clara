FROM alpine
RUN echo "Hello Clara, this is a release test!" > /hello.txt
CMD ["cat", "/hello.txt"]


