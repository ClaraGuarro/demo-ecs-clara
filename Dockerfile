FROM alpine

# Installa mariadb-client invece di mysql-client
RUN apk update && apk add mariadb-client

# Imposta le variabili di ambiente
ENV DB_HOST=$DATABASE_HOST \
    DB_USER=$DATABASE_USERNAME \
    DB_PASS=$DATABASE_PASSWORD \
    DB_NAME=$DATABASE_NAME

# Test di connessione con mariadb al posto di mysql
CMD ["sh", "-c", "echo 'Testing DB connection...' && echo 'DB_HOST='$DB_HOST && echo 'DB_USER='$DB_USER && echo 'DB_PASS='$DB_PASS && echo 'DB_NAME='$DB_NAME && /usr/bin/mariadb -h $DB_HOST -u $DB_USER -p$DB_PASS -e 'SHOW DATABASES;'"]
