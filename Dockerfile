FROM gradle:7.6.1-jdk11 AS build
WORKDIR /home/gradle/demo
COPY . .
RUN ./gradlew build

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /home/gradle/demo/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]