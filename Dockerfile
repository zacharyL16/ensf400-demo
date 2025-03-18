# Use the official Gradle image with JDK 11 as the base image for building the project
FROM gradle:7.6.1-jdk11 AS build
# Set the working directory inside the container where the project files will be copied
WORKDIR /home/gradle/demo
# Copy all project files from the host machine to the container's working directory
COPY . .
# Run the Gradle build command to compile the project and generate the WAR file
RUN ./gradlew build

# Use the official Tomcat 9 image with JDK 11 as the base image for running the application
FROM tomcat:9.0.73-jdk11-temurin


# Copy the built WAR file from the previous build stage into Tomcat's webapps directory
COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war


# Expose port 8080 to allow external access to the Tomcat server
EXPOSE 8080

