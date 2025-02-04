FROM openjdk:17-sdk-slim
WORKDIR /app
COPY target/helloworld-0.0.1-SNAPSHOT.jar helloworld.jar
ENTRYPOINT [ "java", "-jar", "helloworld.jar" ]
EXPOSE 8080