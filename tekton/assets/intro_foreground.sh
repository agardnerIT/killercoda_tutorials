DEBUG_VERSION=7
POD_WAIT_TIMEOUT_MINS=5
TEKTON_CLI_VERSION=0.31.1

wget https://github.com/tektoncd/cli/releases/download/v${TEKTON_CLI_VERSION}/tkn_${TEKTON_CLI_VERSION}_Linux_x86_64.tar.gz
tar -xf tkn_${TEKTON_CLI_VERSION}_Linux_x86_64.tar.gz
sudo mv tkn /usr/bin

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

kubectl -n tekton-pipelines wait --for condition=Available=True --timeout=${POD_WAIT_TIMEOUT_MINS}m deployment/tekton-pipelines-controller
kubectl -n tekton-pipelines wait --for condition=Available=True --timeout=${POD_WAIT_TIMEOUT_MINS}m deployment/tekton-pipelines-webhook

#############################
#   Installation complete   #
#    Please continue...     #
#############################