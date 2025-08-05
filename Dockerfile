# Stage 1: The Build Stage
FROM maven:3-openjdk-11-slim AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: The Runtime Stage
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/NQueensAPI-1.0-SNAPSHOT.jar .
CMD ["java", "-jar", "NQueensAPI-1.0-SNAPSHOT.jar"]