# Use an official Tomcat base image
FROM tomcat:9-jdk11-openjdk

# Set labels for metadata
LABEL maintainer="keyonmwesundze@gmail.com"
LABEL project="webapp-2"

# Remove default web applications deployed with Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to the webapps directory
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war