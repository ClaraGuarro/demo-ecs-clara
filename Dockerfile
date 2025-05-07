FROM alpine

# Installa mariadb-client invece di mysql-client
RUN apk update && apk add mariadb-client

# Imposta le variabili di ambiente
ENV DB_HOST=$DATABASE_HOST \
    DB_USER=$DATABASE_USERNAME \
    DB_PASS=$DATABASE_PASSWORD \
    DB_NAME=$DATABASE_NAME

# Test di connessione con mariadb al posto di mysql
# Esegui il test di connessione
CMD ["sh", "-c", "echo 'Testing DB connection...' && mariadb -h $DB_HOST -u $DB_USER -p$DB_PASS -e 'SHOW DATABASES;' > /tmp/db_output.log 2>&1 && \
     if grep -q 'Database' /tmp/db_output.log; then \
        echo 'Connection successful!'; \
        cat /tmp/db_output.log; \
     else \
        echo 'Connection failed!'; \
        cat /tmp/db_output.log; \
     fi"]
