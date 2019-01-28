FROM openjdk:8-jre-alpine3.7
USER root
WORKDIR /root/
COPY ./target/my-app-1.0-SNAPSHOT.jar /root/app.jar
ENV _JAVA_OPTIONS "-Xms256m -Xmx512m -Djava.awt.headless=true"

ENTRYPOINT ["java", "-jar", "/root/app.jar"]
