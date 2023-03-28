# Intro.md

## Configure and Start Application
Some text about why client-side is better...
This could also be a great opportunity to let users bring their own vendor API keys?

The demo application evaluates feature flags from the client. [This page](https://example.com) explains the benefits of this approach.

The application needs know the flag evaluation endpoint.

Click the following text to configure and start the application now:

```
cat <<EOF > .env
###############################################
##
## Feature Flag Environment Variables
##
###############################################

# Options: recursive, memo, loop, binet, default
FIB_ALGO=default

###############################################
##
## Feature Flag SDK keys (server)
##
###############################################

# Split IO server-side API key
SPLIT_KEY=

# CloudBees App Key
CLOUDBEES_APP_KEY=

# LaunchDarkly SDK Key
LD_KEY=

# Flagsmith Environment key (v2)
FLAGSMITH_ENV_KEY=

# Harness SDK Key
HARNESS_KEY=

###############################################
##
## Feature Flag SDK keys (web)
##
###############################################

# Split IO server-side API key
SPLIT_KEY_WEB=

# CloudBees App Key
CLOUDBEES_APP_KEY_WEB=

# LaunchDarkly SDK Key
LD_KEY_WEB=

# Flagsmith Environment key (v2)
FLAGSMITH_ENV_KEY_WEB=

# Harness SDK Key
HARNESS_KEY_WEB=

# The domain name or IP address of flagd
# @default localhost
FLAGD_HOST_WEB={{TRAFFIC_HOST1_8013}}
EOF
docker compose up --detach
```{{exec}}

## Visit Application

[View the OpenFeature Demo Application]({{TRAFFIC_HOST1_30000}})

If you get a `502`, just give it a few seconds and refresh.

##