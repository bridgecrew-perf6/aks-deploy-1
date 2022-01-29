# --------------------- Start of initial preparation ----------------
# check az cli version
az --version
# upgrade if needed
az upgrade
# check real account name
az account show | Select-String "name"
# print out all possible variants for subscriptions
az account list -o table
# change to the desired subscription
az account set --subscription "my-subscription"
# print out resource group list of subscription
az group list -o table
# ------------------- Create and deploy AKS cluster ------------------ 
# get supported aks versions
az aks get-versions --location eastus --output table
# create resource group for AKS
az group create -l "West Europe" -n "levpa-aks-test"

[CmdletBinding()]
param ($name = 'aks29012022', $rgName = 'levpa-aks-test', $nodeCount = 1, $kubernetesVersion = '1.22.4')

az aks create --generate-ssh-keys `
              --name $name `
              --resource-group $rgName `
              --node-count $nodeCount `
              --kubernetes-version $kubernetesVersion

# merge creds from Azure AKS to ~\.kube\config
az aks get-credentials --name aks29012022 --resource-group levpa-aks-test

# test connection to Azure AKS
kubectl get nodes
# aks-nodepool1-38167155-vmss000000   Ready    agent   8h    v1.22.4

# deploy manifest to AKS cluster
kubectl create -f .\nginx.yml

kubectl get deployments
# NAME               READY   UP-TO-DATE   AVAILABLE   AGE
# nginx-deployment   2/2     2            2           20s

kubectl get service
# NAME            TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)        AGE
# kubernetes      ClusterIP      10.0.0.1      <none>           443/TCP        8h
# nginx-service   LoadBalancer   10.0.39.235   20.103.166.207   80:30920/TCP   2m55s
