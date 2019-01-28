FROM openjdk:8-jre-alpine3.7
VOLUME /tmp
ARG JAR_FILE

WORKDIR /root/
COPY ${JAR_FILE} /root/app.jar
ENV _JAVA_OPTIONS "-Xms256m -Xmx512m -Djava.awt.headless=true"

EXPOSE 8123
ENTRYPOINT ["java", "-jar", "/root/app.jar"]
