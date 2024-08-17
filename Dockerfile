# Use the Postgres Docker image with Alpine Linux
FROM postgres:10.0-alpine

# Optionally, you can define environment variables for the Postgres image
# ENV POSTGRES_USER=myuser
# ENV POSTGRES_PASSWORD=mypassword

# Copy custom pg_hba.conf file
COPY pg_hba.conf /var/lib/postgresql/data/pg_hba.conf

# Optionally, you can copy the SQL script into the container
COPY words.sql /docker-entrypoint-initdb.d/

# Expose the default Postgres port (5432)
EXPOSE 5432

# Start the Postgres database server
CMD ["postgres"]