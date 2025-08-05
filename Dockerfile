# Stage 1: The Build Stage
# Use a Maven image with Java 8 to build the application
FROM maven:3-openjdk-8-slim AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Copy the source code
COPY src ./src

# Build the application, producing a fat JAR
# We use maven-jar-plugin which is already in pom.xml, no extra plugin needed.
RUN mvn clean package -DskipTests

# Stage 2: The Runtime Stage
# Use a lean OpenJDK image for running the application
FROM eclipse-temurin:8-jre-focal

# Set the working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/NQueensAPI-1.0-SNAPSHOT.jar .

# The command to run the application
# We run the fat JAR directly, no classpath needed
CMD ["java", "-jar", "NQueensAPI-1.0-SNAPSHOT.jar"]

