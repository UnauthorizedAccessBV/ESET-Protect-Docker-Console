# ESET PROTECT - Web Console

This container provides the `Web Console` component of `ESET PROTECT`. See the [eset-protect-server](https://hub.docker.com/r/esetnederland/eset-protect-server) page for the server component.

## Quickstart
Run the following command to start the ESET PROTECT Console. The `ESMC_SERVER` parameter configures the ESET Protect Server address.

```shell
docker run --rm --tty --interactive --publish 8080:8080 esetnederland/eset-protect-console
```

The console should now be reachable by browsing to `http://127.0.0.1:8080`.

## Configuration
The following environment variables can be used for configuration:

| Variable                  | 
| ------------------------- | 
| AI_INSTRUMENTATION_KEY    | 
| ALLOW_ADDRESS_CHANGES     | 
| CONFIG_FILE               | 
| CONNECTION_REVERSE_LOOKUP | 
| DBO_REFRESH_INTERVAL      | 
| DEFAULT_USER_LOCALE       | 
| ESMC_SERVER               | 
| HELP_SHOW_ONLINE          | 
| HSTS_ENABLE               | 
| LOGS_MAX_AGE              | 
| LOGS_MAX_SIZE             | 
| LOGS_PATH                 |
| REMOTE_ADDRESS_SOURCE     |
| SERVER_CERTIFICATES       |
| SERVER_PORT               |

The default configuration file can be found at `/config/EraWebServerConfig.properties`, and it's default values are:

```properties
# List of accepted server certificates.
# Use triplets, separated by colons in the form
# algorithm1,password1,certificate1,algorithm2,password2,certificate2
# Do not add whitespaces or other characters.
# The certificate is Base64 encoded, not in its binary form
# (even if the binary form would only use ASCII7 characters).
# Note that MIME Base64 or native Java Base64 may be used. The padding character is '=', the mapping is:
# private static final char[] base64Chars = new char[]
# { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
#   'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
#   's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'}
# or
# private static final char[] base64Chars = new char[]
# { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
#   'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
#   's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '$', '_'}
#
# If you want to accept any server certificate, use "server_certificates=all" (case sensitive)

server_certificates=all

server_address=eset-protect-server
server_port=2223

# If true, webserver will perform reverse DNS lookup for incomming connections, replacing IP address by host name, if available. This will be shown in the list of active connections.
# Setting to true may slow down login significantly in some situations.
# connection_reverse_lookup=false

# Select directory for WebServer logs. If the path is not set or web server has no access, then the default web server logging mechanism is used.
# logs_path=C:\\ProgramData\\Eset\\RemoteAdministrator\\WebConsole
# logs_path=/var/log/eset/RemoteAdministrator/WebConsole

# Select how many megabytes can be used for logs. Logs beyond this limit are deleted.
# Default: logs_max_size=10

# Select how many days should be logs keeped. Once the limit is reached, log is deleted.
# Default: logs_max_age=10

# Note: if you enable both limits, log is deleted when first limit is reached.


# use 4-letters code (language_country)
# default_user_locale=en_US

# Select whether to show online help (offline in case online not available) or just directly offline help by default. Use "true" or "false" values.
# Default: help_show_online=true
help_show_online=true

# Don't change this setting unless you really know what you are doing.
# By default, a session is bound to an internet address. Set to true in case the address can change.
# Disabling address checks can be useful in case of connecting from roaming computers or in case of dual stack (IPv4 vs. IPv6) problems.
# Note that disabling address checks is dangerous. Hijacking of session ID would allow an attacker to connect from a remote computer.
# allow_address_changes=false

# Source of remote address for attack detection. Possible values:
# - connection - directly take the address from connection. This is the default setting.
#   Use this if in your network, there is no network node which changes request address (like proxy or load ballancer).
# - x-forwarded-for-last - use the last value from X-Forwarded-For header.
#   If X-Forwarded-For not present, behave as 'connection'.
#   Use this if in your nerwork you have ONE network node which changes request address (like proxy or load ballancer).
# - x-forwarded-for-first - use the first value from X-Forwarded-For header.
#   If X-Forwarded-For not present, behave as 'connection'.
#   Unsafe. Don't use unless you know what you are doing. Relies on the client not to tamper with the X-Forwarded-For value
#   or on internal infrastructure to strip any values in the X-Forwarded-For header coming from outside.
remote_address_source=connection

# Set HSTS_enable to true to enable HSTS for this application. You can also enable HSTS on your webserver, in that case, this setting can be
# set to false or true.
# Set to false to disable HSTS. This will also inform the browser to remove this host from the list of known HSTS hosts.
# If the value is not specified (commented-out), HSTS header is not added to responses.
# Note that once enabled, you need a valid webpage certificate signed by some trusted root authority.
# HSTS_enable=true

# Time interval in seconds during which dashboard data are stored locally
# Increasing this number will improve dashboards performance
dbo_refresh_interval=30

# instrumentation key for Azure Application Insights
#ai_instrumentation_key=ikey
```

## Volumes
This container uses the `/config` volume to store it's configuration file.