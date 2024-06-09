# Use the openjdk:16-jdk-alpine base image
FROM openjdk:16-jdk-alpine

# Create a new group and user for the Spring application
RUN addgroup -S spring && adduser -S spring -G spring

# Expose port 8080 for the application
EXPOSE 8080

# Set the JAVA_PROFILE environment variable
ENV JAVA_PROFILE prod

# Set the DEPENDENCY argument for the application JAR file
ARG DEPENDENCY=target/dependency

# Copy the application dependencies to the /app/lib directory
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib

# Copy the application metadata to the /app/META-INF directory
COPY ${DEPENDENCY}/META-INF /app/META-INF

# Copy the application classes to the /app directory
COPY ${DEPENDENCY}/BOOT-INF/classes /app

# Set the entrypoint for the container
ENTRYPOINT ["java", \
            "-Dspring.profiles.active=${JAVA_PROFILE}", \
            "-cp", "app:app/lib/*", \
            "camt.se234.lab10.Lab10Application"]