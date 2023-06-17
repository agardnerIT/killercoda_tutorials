LOKI_VERSION=2.8.2
DOCKER_COMPOSE_VERSION=v2.18.1
GRAFANA_VERSION=latest
MINIO_VERSION=latest
NGINX_VERSION=latest
OTELCOL_VERSION=0.79.0
LOGPUSHER_VERSION=v0.1.0

# Pull images for faster startup
# Note: When updating, please also update docker-compose.yaml
docker pull nginx:${NGINX_VERSION}
docker pull grafana/loki:${LOKI_VERSION}
docker pull grafana/grafana:${GRAFANA_VERSION}
docker pull minio/minio:${MINIO_VERSION}
docker pull otel/opentelemetry-collector-contrib:${OTELCOL_VERSION}
docker pull gardner/logpusher:${LOGPUSHER_VERSION}

# Install docker-compose
curl -o docker-compose -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64
chmod +x docker-compose
sudo mv docker-compose /usr/bin
docker-compose --version

# Start Start
docker-compose up -d

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#