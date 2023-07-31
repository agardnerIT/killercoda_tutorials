JAEGER_VERSION=1.47.0
TRACEPUSHER_VERSION=0.8.0
wget -O jaeger.tar.gz https://github.com/jaegertracing/jaeger/releases/download/v${JAEGER_VERSION}/jaeger-${JAEGER_VERSION}-linux-amd64.tar.gz
tar -xf jaeger.tar.gz
chmod +x jaeger-${JAEGER_VERSION}-linux-amd64/jaeger-all-in-one
mv jaeger-${JAEGER_VERSION}-linux-amd64/jaeger-all-in-one /usr/local/bin
wget -O tracepusher https://github.com/agardnerIT/tracepusher/releases/download/${TRACEPUSHER_VERSION}/tracepusher_linux_x64_${TRACEPUSHER_VERSION}
chmod +x tracepusher
mv tracepusher /usr/local/bin

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#