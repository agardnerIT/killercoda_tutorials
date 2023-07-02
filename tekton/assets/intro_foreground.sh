DEBUG_VERSION=4
POD_WAIT_TIMEOUT_MINS=5

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

kubectl -n tekton-pipelines wait --for condition=Available=True --timeout=${POD_WAIT_TIMEOUT_MINS}m deployment/tekton-pipelines-controller
kubectl -n tekton-pipelines wait --for condition=Available=True --timeout=${POD_WAIT_TIMEOUT_MINS}m deployment/tekton-pipelines-webhook

#############################
#   Installation complete   #
#    Please continue...     #
#############################