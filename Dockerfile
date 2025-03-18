FROM gradle:7.6.1-jdk11 AS build
WORKDIR /home/gradle/demo
COPY . .
RUN ./gradlew build

FROM tomcat:9.0.73-jdk11-temurin

COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

