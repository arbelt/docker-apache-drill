FROM alpine:latest AS mirror 
ARG DRILL_VERSION=1.14.0
#COPY ./apache-drill-1.14.0.tar.gz /tmp/drill.tar.gz
RUN apk add -U curl
RUN cd /tmp && \
    curl -L -o drill.tar.gz 'http://www.apache.org/dyn/closer.lua?filename=drill/drill-'${DRILL_VERSION}'/apache-drill-'${DRILL_VERSION}'.tar.gz&action=download' && \
    tar -xvf drill.tar.gz


FROM frolvlad/alpine-oraclejdk8:slim@sha256:05ebcae1120101210ef4bedb0f3ca29909220b90f62e02a58b5c718916116a20
COPY --from=mirror /tmp/apache-drill-1.14.0 /opt/drill
RUN apk add -U --no-cache bash procps

EXPOSE 8047
EXPOSE 31010

ENTRYPOINT []
CMD ["sh", "-c", "/opt/drill/bin/drill-embedded"]

