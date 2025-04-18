FROM maven:3.6.3-jdk-8-slim AS stage1
WORKDIR /home/app
COPY . /home/app/
RUN mvn clean install

FROM openjdk:8-jdk-alpine
EXPOSE 8083
ENV JWT_SECRET=PRFT
ENV SERVER_PORT=8083
COPY --from=stage1 /home/app/target/users-api-0.0.1-SNAPSHOT.jar users-api-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["sh", "-c", "java -jar /users-api-0.0.1-SNAPSHOT.jar"]