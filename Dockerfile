# Use an official OpenJDK runtime as a parent image (Java 17 as required by Petclinic)
FROM eclipse-temurin:17-jre-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the executable jar file built by Maven into the container
# The buildspec runs 'mvn package', which creates the jar in the 'target' directory.
# Using a wildcard (*) accommodates version number changes in the jar filename.
COPY target/spring-petclinic*.jar app.jar

# Make port 8080 available to the world outside this container (standard Spring Boot port)
EXPOSE 8080

# Define the command to run the application when the container launches
ENTRYPOINT ["java","-jar","/app/app.jar"]
