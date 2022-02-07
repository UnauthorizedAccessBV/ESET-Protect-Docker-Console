#!/bin/bash

# Functions
function kill_tomcat() {
  /usr/local/tomcat/bin/catalina.sh stop
}

# Location to config file
if [ -z "${CONFIG_FILE}" ]
then
    CONFIG_FILE="/config/EraWebServerConfig.properties"
fi

# Set server_address
if [ -z "${ESMC_SERVER}" ]
then
    ESMC_SERVER="eset-protect-server"
fi

sed -i -r "s|^([# ]{0,2})server_address=.*$|server_address=$ESMC_SERVER|" $CONFIG_FILE

# Set remote_address_source
if [ -n "${REMOTE_ADDRESS_SOURCE}" ]
then
    sed -i -r "s|^([# ]{0,2})remote_address_source=.*$|remote_address_source=$REMOTE_ADDRESS_SOURCE|" $CONFIG_FILE
fi

# Set server port
if [ -n "${SERVER_PORT}" ]
then
    sed -i -r "s|^([# ]{0,2})server_port=.*$|server_port=$SERVER_PORT|" $CONFIG_FILE
fi

# Set server certificates
if [ -n "${SERVER_CERTIFICATES}" ]
then
    sed -i -r "s|^([# ]{0,2})server_certificates=.*$|server_certificates=$SERVER_CERTIFICATES|" $CONFIG_FILE
fi

# Set reverse lookup
if [ -n "${CONNECTION_REVERSE_LOOKUP}" ]
then
    sed -i -r "s|^([# ]{0,2})connection_reverse_lookup=.*$|connection_reverse_lookup=$CONNECTION_REVERSE_LOOKUP|" $CONFIG_FILE
fi

# Set logs path
if [ -n "${LOGS_PATH}" ]
then
    sed -i -r "s|^([# ]{0,2})logs_path=.*$|logs_path=$LOGS_PATH|" $CONFIG_FILE
fi

# Set max size
if [ -n "${LOGS_MAX_SIZE}" ]
then
    sed -i -r "s|^([# ]{0,2})logs_max_size=.*$|logs_max_size=$LOGS_MAX_SIZE|" $CONFIG_FILE
fi

# Set max age
if [ -n "${LOGS_MAX_AGE}" ]
then
    sed -i -r "s|^([# ]{0,2})logs_max_age=.*$|logs_max_age=$LOGS_MAX_AGE|" $CONFIG_FILE
fi

# Set country code
if [ -n "${DEFAULT_USER_LOCALE}" ]
then
    sed -i -r "s|^([# ]{0,2})default_user_locale=.*$|default_user_locale=$DEFAULT_USER_LOCALE|" $CONFIG_FILE
fi

# Set show help online
if [ -n "${HELP_SHOW_ONLINE}" ]
then
    sed -i -r "s|^([# ]{0,2})help_show_online=.*$|help_show_online=$HELP_SHOW_ONLINE|" $CONFIG_FILE
fi

# Set allow address changes
if [ -n "${ALLOW_ADDRESS_CHANGES}" ]
then
    sed -i -r "s|^([# ]{0,2})allow_address_changes=.*$|allow_address_changes=$ALLOW_ADDRESS_CHANGES|" $CONFIG_FILE
fi

# Set HSTS
if [ -n "${HSTS_ENABLE}" ]
then
    sed -i -r "s|^([# ]{0,2})HSTS_enable=.*$|HSTS_enable=$HSTS_ENABLE|" $CONFIG_FILE
fi

# Set dbo refresh interval
if [ -n "${DBO_REFRESH_INTERVAL}" ]
then
    sed -i -r "s|^([# ]{0,2})dbo_refresh_interval=.*$|dbo_refresh_interval=$DBO_REFRESH_INTERVAL|" $CONFIG_FILE
fi

# Set Azure Application Insights instrumentation key
if [ -n "${AI_INSTRUMENTATION_KEY}" ]
then
    sed -i -r "s|^([# ]{0,2})ai_instrumentation_key=.*$|ai_instrumentation_key=$AI_INSTRUMENTATION_KEY|" $CONFIG_FILE
fi

# Trap SIGTERM signal to kill tomcat daemon
trap kill_tomcat SIGTERM

#/usr/sbin/gosu eset /usr/local/tomcat/bin/catalina.sh run
exec /usr/local/tomcat/bin/catalina.sh run
