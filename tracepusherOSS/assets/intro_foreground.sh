JAEGER_VERSION=1.45
TRACEPUSHER_VERSION=v0.5.0
docker pull jaegertracing/all-in-one:${JAEGER_VERSION}
docker pull gardnera/tracepusher:${TRACEPUSHER_VERSION}

apt install -y bat
alias cat=batcat

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#