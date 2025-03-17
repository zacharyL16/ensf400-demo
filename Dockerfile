FROM gradle:7.6.1-jdk11 AS build
WORKDIR /app
COPY . .
RUN gradle build

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]