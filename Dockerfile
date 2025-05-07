FROM alpine

# Installa mysql-client (se usi MySQL, altrimenti cambia il pacchetto)
RUN apk update && apk add mysql-client

# Imposta le variabili di ambiente che verranno passate
ENV DB_HOST=$DATABASE_HOST \
    DB_USER=$DATABASE_USERNAME \
    DB_PASS=$DATABASE_PASSWORD \
    DB_NAME=$DATABASE_NAME

# Crea un file di test
RUN echo "Hello Clara, this is a release test!" > /hello.txt

# Esegui un test di connessione al database
CMD ["sh", "-c", "echo 'Testing DB connection...' && mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e 'SHOW DATABASES;' && cat /hello.txt"]


