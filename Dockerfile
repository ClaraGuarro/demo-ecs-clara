FROM amazonlinux:2

# Update e installazione dei pacchetti necessari
RUN yum update -y && yum install -y \
    mariadb \
    mariadb-client \
    iputils \
    net-tools \
    nc \
    bind-utils \
    && yum clean all

# Imposta le variabili di ambiente
ENV DB_HOST=$DATABASE_HOST \
    DB_USER=$DATABASE_USERNAME \
    DB_PASS=$DATABASE_PASSWORD \
    DB_NAME=$DATABASE_NAME

# Test di connessione al database e log dettagliato
CMD ["/bin/sh", "-c", "\
    echo 'Testing DB connection...'; \
    echo 'Host: '$DB_HOST; \
    echo 'User: '$DB_USER; \
    echo 'Database: '$DB_NAME; \
    env | grep DB_; \
    if [ -z \"$DB_HOST\" ]; then \
        echo '❌ ERRORE: DB_HOST è vuoto!'; \
        exit 1; \
    fi; \
    echo '🔍 Risoluzione DNS...'; \
    host $DB_HOST; \
    if ping -c 1 $DB_HOST > /dev/null; then \
        echo '✅ Host raggiungibile'; \
    else \
        echo '❌ Impossibile raggiungere il database'; \
        exit 1; \
    fi; \
    echo 'Tentativo di connessione a MariaDB...'; \
    mariadb -h $DB_HOST -u $DB_USER -p$DB_PASS -e 'SHOW DATABASES;' > /tmp/db_output.log 2>&1; \
    if grep -q 'Database' /tmp/db_output.log; then \
        echo '✅ Connessione riuscita!'; \
        cat /tmp/db_output.log; \
    else \
        echo '❌ Connessione fallita!'; \
        cat /tmp/db_output.log; \
        exit 1; \
    fi"]
