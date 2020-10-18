FROM gcr.io/fivetran-donkeys/openjdk:8u242
COPY libdontdie-1.2.0.tar.xz libdontdie-1.2.0.tar.xz
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    && tar -xvf libdontdie-1.2.0.tar.xz \
    && make -C libdontdie-1.2.0

FROM gcr.io/fivetran-donkeys/openjdk:8u242
COPY binary_deploy.jar app.jar
COPY --from=0 /libdontdie-1.2.0/libdontdie.so /usr/lib/libdontdie.so
RUN apt-get update && \
    apt-get -y install net-tools tcpdump
ENTRYPOINT ["java","-jar","-Djava.security.egd=file:///dev/urandom","-XX:+UnlockExperimentalVMOptions","-XX:+UseCGroupMemoryLimitForHeap","/app.jar"]