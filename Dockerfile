#
# Build stage
#
FROM maven:3.8.4-openjdk-11-slim AS build
COPY --chown=maven:maven . /home/maven/src
WORKDIR /home/maven/src
RUN mvn clean package

LABEL org.name="huimi"
#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/maven/src/target/demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]