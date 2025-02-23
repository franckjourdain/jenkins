# Use an official OpenJDK runtime as a parent image
FROM eclipse-temurin:17-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the host to the container
COPY jenkins-0.0.1-SNAPSHOT.jar app.jar

# Specify the command to run the jar file
CMD ["java", "-jar", "app.jar"]