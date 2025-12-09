# Base image to run jar file
FROM amazoncorretto:8-alpine3.20-jre

EXPOSE 8080

COPY ./target/java-maven-app-*.jar /usr/app
WORKDIR /usr/app

CMD java -jar java-maven-app-*.jar