#!/usr/bin/env sh

echo "#========================================================================#"
echo "# Starting Enriched Deployment                                           #"
echo "#========================================================================#"

echo "# Send Deployment Notification Event to Dynatrace #"
curl -X POST $DT_ENVIRONMENT/api/v2/events/ingest \
-H "Authorization: Api-Token $EVENTS_INGEST_TOKEN" \
-H "Accept: application/json; charset=utf-8" \
-H "Content-Type: application/json; charset=utf-8" \
--data-raw "
  {
    \"eventType\": \"CUSTOM_DEPLOYMENT\",
    \"title\": \"Running Stress Tool\",
    \"timeout\": 5,
    \"entitySelector\": \"type(HOST),tag([ENVIRONMENT]demo:cpu_stress)\",
    \"properties\": {
      \"dt.event.description\": \"Demo to show the power of Dynatrace events...\",
      \"dt.event.deployment.name\": \"deploy stress tool\",
      \"dt.event.deployment.project\": \"my_project\",
      \"dt.event.deployment.release_stage\": \"production\",
      \"dt.event.deployment.release_product\": \"my_website\",
      \"dt.event.deployment.version\": \"v1.0.0\",
      \"dt.event.deployment.remediation_action_link\": \"https://example.com/this_is_the_fix\",
      \"dt.event.is_rootcause_relevant\": true,
      \"dt.event.deployment.ci_back_link\": \"https://example.com/pipeline/run/123\",
      \"owner\": \"YourName\",
      \"approver\": \"bob\",
      \"approver email\": \"bob@example.com\",
      \"escalation contact\": \"sarah\",
      \"escalation contact number\": \"12345\",
      \"ticket number\": \"TEST001\",
      \"ticket link\": \"https://example.com/TEST001\"
    }
  }
  "

  echo "# Run Stress Tool (Simulate a bad deployment) #"
  stress -c 10 -t 5m