FROM gcr.io/fivetran-donkeys/openjdk:8u242
COPY libkeepalive-0.3.tar.gz libkeepalive-0.3.tar.gz
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    && tar -xvf libkeepalive-0.3.tar.gz \
    && make -C libkeepalive-0.3

FROM gcr.io/fivetran-donkeys/openjdk:8u242
COPY --from=0 /libkeepalive-0.3/libkeepalive.so /usr/lib/libkeepalive.so