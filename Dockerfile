# Stage 1: The Build Stage
# Use a Maven image with Java 11 to build the application
FROM maven:3-openjdk-11-slim AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Copy the source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: The Runtime Stage
# Use a lean OpenJDK 11 JRE image for running the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/NQueensAPI-1.0-SNAPSHOT.jar .

# The command to run the application
CMD ["java", "-jar", "NQueensAPI-1.0-SNAPSHOT.jar"]
