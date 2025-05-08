FROM amazonlinux:2

# Update e installazione dei pacchetti necessari
RUN yum update -y && yum install -y \
    mariadb \
    mariadb-client \
    iputils \
    net-tools \
    nc \
    unzip \
    && yum clean all

# Installazione di AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Imposta le variabili di ambiente
ENV DB_HOST=$DATABASE_HOST \
    DB_USER=$DATABASE_USERNAME \
    DB_PASS=$DATABASE_PASSWORD \
    DB_NAME=$DATABASE_NAME

# Test di connessione al database e log dettagliato
CMD ["/bin/sh", "-c", "\
    echo 'Testing DB connection...'; \
    echo '--- DEBUG ENVIRONMENT VARIABLES ---'; \
    echo 'DATABASE_HOST='$DATABASE_HOST; \
    echo 'DATABASE_USERNAME='$DATABASE_USERNAME; \
    echo 'DATABASE_PASSWORD='$DATABASE_PASSWORD; \
    echo 'DATABASE_NAME='$DATABASE_NAME; \
    echo '--- AWS SSM GET PARAMETERS ---'; \
    aws ssm get-parameter --name $DATABASE_HOST --region us-east-1 --with-decryption || echo 'Parameter not found'; \
    aws ssm get-parameter --name $DATABASE_USERNAME --region us-east-1 --with-decryption || echo 'Parameter not found'; \
    aws ssm get-parameter --name $DATABASE_PASSWORD --region us-east-1 --with-decryption || echo 'Parameter not found'; \
    aws ssm get-parameter --name $DATABASE_NAME --region us-east-1 --with-decryption || echo 'Parameter not found'; \
    echo '--- TESTING DATABASE CONNECTION ---'; \
    mysql -h $DATABASE_HOST -u $DATABASE_USERNAME -p$DATABASE_PASSWORD -e 'SHOW DATABASES;' || echo '❌ ERRORE: Connessione al database fallita!'; \
    if [ -z \"$DATABASE_HOST\" ]; then \
        echo '❌ ERRORE: DATABASE_HOST è vuoto!'; \
        exit 1; \
    fi"]

