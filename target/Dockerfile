# Use a base image with Java 8
FROM eclipse-temurin:8-jdk-focal

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Copy the source code
COPY src ./src

# Build the application
RUN mvn package

# The command to run the application (using your package structure)
CMD ["java", "-cp", "target/classes", "org.example.NQueensAPI"]