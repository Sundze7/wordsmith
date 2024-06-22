# Use the Postgres Docker image with Alpine Linux
FROM postgres:10.0-alpine

# Optionally, you can define environment variables for the Postgres image
# ENV POSTGRES_USER=myuser
# ENV POSTGRES_PASSWORD=mypassword

# Optionally, you can copy any additional scripts or configurations
# into the container if needed
# COPY myscript.sh /docker-entrypoint-initdb.d/

# Expose the default Postgres port (5432)
EXPOSE 5432

# Start the Postgres database server
CMD ["postgres"]