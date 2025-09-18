# See https://help.eset.com/protect_install/90/en-US/component_installation_webconsole_windows_manually.html
FROM tomcat:9.0-jdk21 AS builder

# Version
ARG ESET_VERSION=12.1.260.0

# Install dependencies, download and unpack the webconsole
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o /tmp/era_x64.war https://repository.eset.com/v1/com/eset/apps/business/era/webconsole/v12/${ESET_VERSION}/era_x64.war \
    && unzip -d /usr/local/tomcat/webapps/era /tmp/era_x64.war \
    && rm /tmp/era_x64.war

FROM tomcat:9.0-jdk21

# Create user, directories, and symlinks
RUN groupadd -r eset -g 3537 \
    && useradd --no-log-init -r -g eset -u 3537 eset \
    && rm -rf /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config \
    && mkdir /config \
    && ln -s /config /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config \
    && chown -R eset:eset /config

# Copy application files from the builder stage
COPY --from=builder /usr/local/tomcat/webapps/era /usr/local/tomcat/webapps/era/
COPY --from=builder /usr/local/tomcat/webapps/era/WEB-INF/classes/sk/eset/era/g2webconsole/server/modules/config /config

# Copy local files and set permissions
COPY files/index.html /usr/local/tomcat/webapps/ROOT/index.html
COPY files/context.xml /usr/local/tomcat/conf/context.xml
COPY files/run.sh /run.sh
COPY files/healthcheck.sh /healthcheck.sh
RUN chmod +x /run.sh /healthcheck.sh

# Volumes
VOLUME [ "/config" ]

# Ports
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=1m --timeout=10s --start-period=30s \
    CMD /healthcheck.sh

# Set user
USER eset

# Entrypoint
ENTRYPOINT [ "/run.sh" ]
