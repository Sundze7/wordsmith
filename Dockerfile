# Use an official Tomcat base image
# FROM tomcat:9-jdk11-openjdk
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file and dependencies into the container
COPY target/words.jar /app/words.jar
COPY target/dependency/*.jar /app/dependency/

# Define the command to run when the container starts
CMD ["java", "-cp", "/app/words.jar:/app/dependency/*", "Main"]
