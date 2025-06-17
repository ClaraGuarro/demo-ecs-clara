FROM amazonlinux:2

# Update e installazione dei pacchetti necessari
RUN yum update -y

CMD ["/bin/bash"]
