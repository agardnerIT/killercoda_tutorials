echo "Port Forwarding. Access using Port 8080."
echo ""
nohup kubectl -n keptn port-forward --address 0.0.0.0 service/api-gateway-nginx 8080:80 &
echo "Please continue..."