#!/usr/bin/env sh

echo "#=================================#"
echo "# Please enter Dynatrace details now    #"
echo "#=================================#"
read -p 'Environment URL (eg. https://abc12345.live.dynatrace): ' DT_ENVIRONMENT
read -p 'PaaS Token: ' PAAS_TOKEN
read -p 'Events Ingest Token: ' EVENTS_INGEST_TOKEN

export DT_ENVIRONMENT=$DT_ENVIRONMENT
export PAAS_TOKEN=$PAAS_TOKEN
export EVENTS_INGEST_TOKEN=$EVENTS_INGEST_TOKEN

echo ""
echo "#=================================#"
echo "         Details Set:              "
echo "#=================================#"
echo ""
echo "Environment URL: $DT_ENVIRONMENT"
echo "PaaS Token: $PAAS_TOKEN"
echo "Events Ingest Token: $EVENTS_INGEST_TOKEN"

echo ""
echo "============================================================="
echo "Made a mistake? Easy. Just click the command again on the left to reset everything."
echo "Everything look good? Proceed with the tutorial..."
echo "============================================================="