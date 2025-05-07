FROM amazonlinux:2

# Update e installazione dei pacchetti necessari
RUN yum update -y && yum install -y \
    mariadb \
    mariadb-client \
    iputils \
    net-tools \
    nc \
    && yum clean all

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
    aws ssm get-parameter --name $DATABASE_HOST --region us-east-1 --with-decryption; \
    aws ssm get-parameter --name $DATABASE_USERNAME --region us-east-1 --with-decryption; \
    aws ssm get-parameter --name $DATABASE_PASSWORD --region us-east-1 --with-decryption; \
    aws ssm get-parameter --name $DATABASE_NAME --region us-east-1 --with-decryption; \
    env | grep DATABASE_; \
    if [ -z \"$DATABASE_HOST\" ]; then \
        echo '❌ ERRORE: DATABASE_HOST è vuoto!'; \
        exit 1; \
    fi"]

