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



