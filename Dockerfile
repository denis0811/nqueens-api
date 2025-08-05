# Stage 1: The Build Stage
FROM maven:3-openjdk-11-slim AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
# The assembly plugin creates a JAR with "-jar-with-dependencies" in the name
RUN mvn clean package -DskipTests

# Stage 2: The Runtime Stage
FROM openjdk:11-jre-slim
WORKDIR /app
# Copy the fat JAR from the builder stage
COPY --from=builder /app/target/NQueensAPI-1.0-SNAPSHOT-jar-with-dependencies.jar .

# The command to run the fat JAR
CMD ["java", "-jar", "NQueensAPI-1.0-SNAPSHOT-jar-with-dependencies.jar"]
