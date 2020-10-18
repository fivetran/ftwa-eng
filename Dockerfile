FROM gcr.io/sandbox-testing-215308/openjdk:8u242-libkeepalive
COPY binary_deploy.jar app.jar
RUN apt-get update && \
    apt-get -y install net-tools tcpdump
ENTRYPOINT ["java","-jar","-Djava.security.egd=file:///dev/urandom","-XX:+UnlockExperimentalVMOptions","-XX:+UseCGroupMemoryLimitForHeap","/app.jar"]