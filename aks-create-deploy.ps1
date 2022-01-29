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

