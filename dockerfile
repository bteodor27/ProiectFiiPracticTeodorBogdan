FROM gradle:8.5-jdk11 AS builder
WORKDIR /app
COPY springboot /app
RUN chmod +x ./gradlew && ./gradlew build --no-daemon
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
