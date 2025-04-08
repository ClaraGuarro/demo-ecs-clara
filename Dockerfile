FROM alpine
RUN echo "Hello Clara!" > /hello.txt
CMD ["cat", "/hello.txt"]


