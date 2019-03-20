#!/bin/sh
set -e
envsubst < /tmp/config.yml.template > /opt/jmx_exporter/config.yml

if [ -z "$SERVICE_PORT" ]; then
  SERVICE_PORT=5556
fi

if [ -z "$CONFIG_YML" ]; then
  CONFIG_YML=/opt/jmx_exporter/config.yml
fi

if [ "$DEBUG" = true ]; then
  LOGGING_CONFIG=-Djava.util.logging.config.file=/opt/jmx_exporter/logging.properties
fi

java $JVM_OPTS $LOGGING_CONFIG -jar /opt/jmx_exporter/jmx_prometheus_httpserver-$VERSION-jar-with-dependencies.jar $SERVICE_PORT $CONFIG_YML
