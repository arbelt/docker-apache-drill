FROM alpine:latest AS mirror 
#COPY ./apache-drill-1.14.0.tar.gz /tmp/drill.tar.gz
RUN apk add -U curl
RUN cd /tmp && \
    curl -L -o drill.tar.gz 'http://www.apache.org/dyn/closer.lua?filename=drill/drill-1.14.0/apache-drill-1.14.0.tar.gz&action=download' && \
    tar -xvf drill.tar.gz


FROM openjdk:alpine
COPY --from=mirror /tmp/apache-drill-1.14.0 /opt/drill
RUN apk add -U --no-cache bash procps

ENTRYPOINT []
CMD ["sh", "-c", "/opt/drill/bin/drill-embedded"]

