# Use an official Tomcat base image
FROM openjdk11:jdk-11.0.11_9-alpine-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file and dependencies into the container
COPY target/words.jar /app/words.jar
COPY target/dependency/*.jar /app/dependency/

# Define the command to run when the container starts
CMD ["java", "-cp", "/app/words.jar:/app/dependency/*", "Main"]