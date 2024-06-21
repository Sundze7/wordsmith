# Use an official Tomcat base image
FROM tomcat:9-jdk11-openjdk

# Set the working directory inside the container
WORKDIR /app

# Copy the .jar file from the target directory to the container
COPY target/*.jar app.jar
