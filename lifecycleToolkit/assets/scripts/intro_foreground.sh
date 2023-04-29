##############################################
# 1/2: Install Keptn Lifecycle Toolkit
##############################################
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait

##############################################
# 2/2: Clone Example Code
##############################################
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git