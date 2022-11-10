# See https://support.eset.com/en/install-esmc-web-console-using-jdk
FROM tomcat:9-jdk16-openjdk-slim

# Version
ARG ESET_VERSION=10.0.132.0

# Install dependencies
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
  unzip \
  curl \
&& rm -rf /var/lib/apt/lists/*

# Create user
RUN groupadd -r eset -g 3537 \
  &&  useradd --no-log-init -r -g eset -u 3537 eset

# Add era.war, index.html, context.xml, healthcheck.sh and run.sh
ADD https://repository.eset.com/v1/com/eset/apps/business/era/webconsole/v10/${ESET_VERSION}/era_x64.war /tmp/
COPY files/index.html /usr/local/tomcat/webapps/ROOT/index.html
COPY files/context.xml /usr/local/tomcat/conf/context.xml
COPY files/run.sh /run.sh
COPY files/healthcheck.sh /healthcheck.sh
RUN chmod +x \
  /run.sh \
  /healthcheck.sh

# Extract war
RUN mkdir -p /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules \
  && mkdir /config \
  && ln -s /config /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config \
  && unzip -d /usr/local/tomcat/webapps/era /tmp/era.war \
  && rm -r /tmp/era.war \
  && chown -R eset:eset /config

# Volumes
VOLUME [ "/config" ]

# Ports
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=1m --timeout=10s --start-period=30m \  
 CMD /healthcheck.sh

# Set user
USER eset

# Entrypoint
ENTRYPOINT [ "/run.sh" ]
