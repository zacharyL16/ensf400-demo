FROM gradle:7.6.1-jdk11 AS build
WORKDIR /home/gradle/src
COPY . .
RUN gradle build

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]