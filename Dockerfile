# Multistage Process

# Stage 1: Artifact Source Stage
# Define an intermediate stage (using the minimal 'scratch' image)
# solely to hold the application JAR copied from the build context.
FROM scratch AS artifact_source
WORKDIR /app
# Copy the JAR built externally by 'mvn package' (in CodeBuild) into this stage
COPY target/spring-petclinic*.jar app.jar

# Stage 2: Final Runtime Stage
# Use the lean JRE Alpine image for running the application
# --- MODIFIED LINE BELOW ---
FROM public.ecr.aws/docker/library/eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy *only* the application JAR from the intermediate artifact_source stage
COPY --from=artifact_source /app/app.jar /app/app.jar

# Expose the application port
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java","-jar","/app/app.jar"]
