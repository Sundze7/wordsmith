# Use an official Tomcat base image
# FROM tomcat:9-jdk11-openjdk
# FROM openjdk:17-jdk-slim
 FROM openjdk:17-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file and dependencies into the container
COPY target/words.jar /app/words.jar
COPY target/dependency/*.jar /app/dependency/

# Define the command to run when the container starts
CMD ["java", "-cp", "/app/words.jar:/app/dependency/*", "Main"]


# # Use a base image with Java and Maven installed
# FROM maven:3.8.4-openjdk-17-slim AS build
# WORKDIR /app

# # Copy the source code and pom.xml
# COPY src/ ./src/
# COPY pom.xml .

# # Download dependencies and compile the application
# RUN mvn -B dependency:go-offline
# RUN mvn -B clean package

# # Create the final image with the compiled application
# FROM openjdk:17-jdk-slim
# WORKDIR /app
# COPY --from=build /app/target/words.jar ./words.jar

# # Set the entry point to run the application
# CMD ["java", "-jar", "words.jar"]