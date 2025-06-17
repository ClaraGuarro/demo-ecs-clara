FROM amazonlinux:2

# Update e installazione dei pacchetti necessari
RUN yum update -y

# Installazione di AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

CMD ["/bin/bash"]
