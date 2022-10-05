#!/usr/bin/env sh

echo "#==================================#"
echo "# Installing Dynatrace OneAgent    #"
echo "#==================================#"
wget -O Dynatrace-OneAgent-Linux.sh "$DT_ENVIRONMENT/api/v1/deployment/installer/agent/unix/default/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $PAAS_TOKEN"
sudo /bin/sh Dynatrace-OneAgent-Linux.sh --set-infra-only=false --set-app-log-content-access=true --set-host-group=events-demo --set-host-tag=demo=cpu_stress
