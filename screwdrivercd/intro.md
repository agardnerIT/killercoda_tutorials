Wait until prompted then enter your `client ID` and `client secret`.

When asked to run the commands now, enter `n`.

Now click this to modify the docker-compose.yaml:

```
sed -i "s#URI: http://172.30.1.2:9001#{{TRAFFIC_HOST1_9001}}#g" ~/docker-compose.yml
sed -i "s#ECOSYSTEM_UI: http://172.30.1.2:9000#{{TRAFFIC_HOST1_9000}}#g" ~/docker-compose.yml
sed -i "s#ECOSYSTEM_STORE: http://172.30.1.2:9002#{{TRAFFIC_HOST1_9002}}#g" ~/docker-compose.yml
sed -i "s#ECOSYSTEM_API: http://172.30.1.2:9001#{{TRAFFIC_HOST1_9001}}#g" ~/docker-compose.yml
```{{exec}}

Now start Screwdriver:

```
docker-compose -p screwdriver up -d
```{{exec}}