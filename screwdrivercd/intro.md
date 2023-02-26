This is a work in progress. Expect a full tutorial / walkthrough here.

Wait until prompted then enter the Git provider you want to use.

You will then be prompted for your `client ID` and `client secret`.

When asked to run the commands now, enter `n`.

Now click this to modify the docker-compose.yaml:

```
cp ~/docker-compose.yml ~/docker-compose.yml.BAK
sed -i "s#URI: http://172.30.1.2:9001#URI: {{TRAFFIC_HOST1_9001}}#g" ~/docker-compose.yml
sed -i "s#URI: http://172.30.1.2:9002#URI: {{TRAFFIC_HOST1_9002}}#g" ~/docker-compose.yml
sed -i "s#ECOSYSTEM_UI: http://172.30.1.2:9000#ECOSYSTEM_UI: {{TRAFFIC_HOST1_9000}}#g" ~/docker-compose.yml
sed -i "s#ECOSYSTEM_STORE: http://172.30.1.2:9002#ECOSYSTEM_STORE: {{TRAFFIC_HOST1_9002}}#g" ~/docker-compose.yml
sed -i "s#ECOSYSTEM_API: http://172.30.1.2:9001#ECOSYSTEM_API: {{TRAFFIC_HOST1_9001}}#g" ~/docker-compose.yml
```{{exec}}

Now start Screwdriver:

```
docker-compose -p screwdriver up -d
```{{exec}}

## Open UI

[Click here to open Screwdriver...]({{TRAFFIC_HOST1_9001}})