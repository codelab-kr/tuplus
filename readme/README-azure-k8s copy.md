
# Install
### Terraform
https://developer.hashicorp.com/terraform/downloads
```bash
# for Mac
➜  brew tap hashicorp/tap
➜  brew install hashicorp/tap/terraform

# for Ubuntu
➜  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
➜  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
➜  sudo apt update && sudo apt install terraform

➜  terraform version 
Terraform v1.5.7
on darwin_arm64
```

### Azure CLI 
https://learn.microsoft.com/ko-kr/cli/azure/install-azure-cli
```bash
# for Mac
➜  brew update && brew install azure-cli

# for Ubuntu
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash


https://github.com/kubernetes-sigs/cluster-api-provider-azure
https://capz.sigs.k8s.io/

➜  az login

az account list -o table

export AZURE_SUBSCRIPTION_ID="<SubscriptionId>"
export AZURE_SUBSCRIPTION_ID="78c4440c-2050-4d5a-93f3-e30263f35cd9"


# 권한부여
➜  export MSYS_NO_PATHCONV=1   
➜  az ad sp create-for-rbac \
  --name azure-cli-agent
  --role="Contributor" \
  --role="User Access Administrator" \
  --scopes="/subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9"


{
  "appId": "ba843b1d-7d03-420c-9363-a5f8b1d8dc2b",
  "displayName": "azure-cli-agent",
  "password": "AX28Q~N3cj6sJWQ66CZhTB_O0AZ.vCjgjZ~CvcwA",
  "tenant": "851f3767-766a-4cd9-ac0e-84a8762c6130"
}


az role assignment create --assignee ba843b1d-7d03-420c-9363-a5f8b1d8dc2b --role "User Access Administrator" --scope /subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9/resourceGroups/tuplus
# role "User Access Administrator" 
➜  az role assignment create --assignee <principalId/개체ID> --role <roleDefinitionId> --scope /subscriptions/<구독ID>/resourceGroups/tuplus
➜  az role assignment create --assignee ba843b1d-7d03-420c-9363-a5f8b1d8dc2b --role "User Access Administrator" --scope /subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9/resourceGroups/tuplus
{
  "condition": null,
  "conditionVersion": null,
  "createdBy": null,
  "createdOn": "2023-10-04T08:22:29.427447+00:00",
  "delegatedManagedIdentityResourceId": null,
  "description": null,
  "id": "/subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9/resourceGroups/tuplus/providers/Microsoft.Authorization/roleAssignments/1c35e702-e234-4744-8136-bad6ca5c2a8a",
  "name": "1c35e702-e234-4744-8136-bad6ca5c2a8a",
  "principalId": "2b2aa0c8-f8ed-4c63-b78a-e104ff12fd6d",
  "principalType": "ServicePrincipal",
  "resourceGroup": "tuplus",
  "roleDefinitionId": "/subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9",
  "scope": "/subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9/resourceGroups/tuplus",
  "type": "Microsoft.Authorization/roleAssignments",
  "updatedBy": "5fce65d6-54bf-452c-b670-da121b97ef47",
  "updatedOn": "2023-10-04T08:22:29.582451+00:00"
}



➜  az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.Compute
az provider register -n Microsoft.Network
az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.ManagedIdentity
az provider register -n Microsoft.Authorization
az provider register -n Microsoft.ResourceHealth



export AZURE_SUBSCRIPTION_ID="78c4440c-2050-4d5a-93f3-e30263f35cd9"

# Create an Azure Service Principal and paste the output here
export AZURE_TENANT_ID="851f3767-766a-4cd9-ac0e-84a8762c6130"
export AZURE_CLIENT_ID=""
export AZURE_CLIENT_SECRET=""

# Base64 encode the variables
export AZURE_SUBSCRIPTION_ID_B64="$(echo -n "$AZURE_SUBSCRIPTION_ID" | base64 | tr -d '\n')"
export AZURE_TENANT_ID_B64="$(echo -n "$AZURE_TENANT_ID" | base64 | tr -d '\n')"
export AZURE_CLIENT_ID_B64="$(echo -n "$AZURE_CLIENT_ID" | base64 | tr -d '\n')"
export AZURE_CLIENT_SECRET_B64="$(echo -n "$AZURE_CLIENT_SECRET" | base64 | tr -d '\n')"

# Settings needed for AzureClusterIdentity used by the AzureCluster
export AZURE_CLUSTER_IDENTITY_SECRET_NAME="cluster-identity-secret"
export CLUSTER_IDENTITY_NAME="cluster-identity"
export AZURE_CLUSTER_IDENTITY_SECRET_NAMESPACE="default"

# Create a secret to include the password of the Service Principal identity created in Azure
# This secret will be referenced by the AzureClusterIdentity used by the AzureCluster
➜  kubectl create secret generic "${AZURE_CLUSTER_IDENTITY_SECRET_NAME}" --from-literal=clientSecret="${AZURE_CLIENT_SECRET}" --namespace "${AZURE_CLUSTER_IDENTITY_SECRET_NAMESPACE}" 
secret/cluster-identity-secret created


cat << EOT > azure-cluster-identity.yaml
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureClusterIdentity
metadata:
  labels:
    clusterctl.cluster.x-k8s.io/move-hierarchy: "true"
  name: cluster-identity
  namespace: default
spec:
  allowedNamespaces: {}
  clientID: ba843b1d-7d03-420c-9363-a5f8b1d8dc2b
  clientSecret: 
    name: cluster-identity-secret
    namespace: default
  tenantID: 851f3767-766a-4cd9-ac0e-84a8762c6130
  type: ServicePrincipal
EOT
k apply -f azure-cluster-identity.yaml


# Finally, initialize the management cluster
➜  clusterctl init --infrastructure azure:v1.1.1 
# azure:v1.1.2 설치 안 됨 (cpu 리소스 부족, 아키텍처 안 맞음 등)
Fetching providers
Skipping installing cert-manager as it is already installed
Installing Provider="infrastructure-azure" Version="v1.1.1" TargetNamespace="capz-system"

# 1.1.1 설치하고 pod pending 이면 관련 리소스 작게 줄이기
➜  k edit daemonset.apps/capz-nmi -n capz-system 
daemonset.apps/capz-nmi edited

cf.
az vm image list --publisher cncf-upstream --offer capi --all -o table
Architecture    Offer         Publisher      Sku                                     Urn                                                                           Version
x64             capi          cncf-upstream  ubuntu-2204-gen1                        cncf-upstream:capi:ubuntu-2204-gen1:128.2.20230918                            128.2.20230918

x64             capi          cncf-upstream  ubuntu-2004-gen1                        cncf-upstream:capi:ubuntu-2004-gen1:128.2.20230918                            128.2.20230918




clusterctl generate cluster azure \
  --kubernetes-version v1.28.0 \
  --control-plane-machine-count=1 \
  --worker-machine-count=2 \
  --infrastructure azure \
  > azure.yaml


➜   kubectl apply -f azure.yaml
cluster.cluster.x-k8s.io/azure-seoul created
azurecluster.infrastructure.cluster.x-k8s.io/azure-seoul created
kubeadmcontrolplane.controlplane.cluster.x-k8s.io/azure-seoul-control-plane created
azuremachinetemplate.infrastructure.cluster.x-k8s.io/azure-seoul-control-plane created
machinedeployment.cluster.x-k8s.io/azure-seoul-md-0 created
azuremachinetemplate.infrastructure.cluster.x-k8s.io/azure-seoul-md-0 created
kubeadmconfigtemplate.bootstrap.cluster.x-k8s.io/azure-seoul-md-0 created
azureclusteridentity.infrastructure.cluster.x-k8s.io/cluster-identity unchanged

```


# Terraform apply
```bash
➜  terraform init
➜  terraform plan
➜  terraform apply
...
Outputs:

registry_hostname = "tuplus.azurecr.io"
registry_id = "/subscriptions/78c4440c-2050-4d5a-93f3-e30263f35cd9/resourceGroups/tuplus/providers/Microsoft.ContainerRegistry/registries/tuplus"
registry_pw = <sensitive>
registry_un = "tuplus"
storage_account_connection_string = <sensitive>



# registry_pw
➜  terraform output -raw registry_pw
➜  az acr credential show --name tuplus --output table


# storage_account_connection_string
➜  terraform output -raw storage_account_connection_string
➜  az acr credential show --name tuplus --output table


# get node
➜  kubectl get nodes --kubeconfig kubeconfig
NAME                              STATUS   ROLES   AGE     VERSION
aks-default-23725562-vmss000000   Ready    agent   2m13s   v1.27.3
aks-default-23725562-vmss000001   Ready    agent   2m25s   v1.27.3

# get all
➜  kubectl get all --kubeconfig kubeconfig -A
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   pod/azure-ip-masq-agent-hkpqg             1/1     Running   0          24m
kube-system   pod/azure-ip-masq-agent-pvspw             1/1     Running   0          24m
kube-system   pod/cloud-node-manager-2mtnx              1/1     Running   0          24m
kube-system   pod/cloud-node-manager-hnvrp              1/1     Running   0          24m
kube-system   pod/coredns-789789675-wqb7r               1/1     Running   0          24m
kube-system   pod/coredns-789789675-x2ssh               1/1     Running   0          23m
kube-system   pod/coredns-autoscaler-649b947bbd-q5jmg   1/1     Running   0          24m
kube-system   pod/csi-azuredisk-node-8jnkw              3/3     Running   0          24m
kube-system   pod/csi-azuredisk-node-w7sdd              3/3     Running   0          24m
kube-system   pod/csi-azurefile-node-fc424              3/3     Running   0          24m
kube-system   pod/csi-azurefile-node-hmqts              3/3     Running   0          24m
kube-system   pod/konnectivity-agent-6c6b9bfc8b-tjlr8   1/1     Running   0          14m
kube-system   pod/konnectivity-agent-6c6b9bfc8b-vc29x   1/1     Running   0          14m
kube-system   pod/kube-proxy-8c78w                      1/1     Running   0          24m
kube-system   pod/kube-proxy-hh5xf                      1/1     Running   0          24m
kube-system   pod/metrics-server-5955767688-5bgk7       2/2     Running   0          23m
kube-system   pod/metrics-server-5955767688-5tdlf       2/2     Running   0          23m

NAMESPACE     NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)         AGE
default       service/kubernetes       ClusterIP   10.0.0.1       <none>        443/TCP         24m
kube-system   service/kube-dns         ClusterIP   10.0.0.10      <none>        53/UDP,53/TCP   24m
kube-system   service/metrics-server   ClusterIP   10.0.161.135   <none>        443/TCP         24m

NAMESPACE     NAME                                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   daemonset.apps/azure-ip-masq-agent          2         2         2       2            2           <none>          24m
kube-system   daemonset.apps/cloud-node-manager           2         2         2       2            2           <none>          24m
kube-system   daemonset.apps/cloud-node-manager-windows   0         0         0       0            0           <none>          24m
kube-system   daemonset.apps/csi-azuredisk-node           2         2         2       2            2           <none>          24m
kube-system   daemonset.apps/csi-azuredisk-node-win       0         0         0       0            0           <none>          24m
kube-system   daemonset.apps/csi-azurefile-node           2         2         2       2            2           <none>          24m
kube-system   daemonset.apps/csi-azurefile-node-win       0         0         0       0            0           <none>          24m
kube-system   daemonset.apps/kube-proxy                   2         2         2       2            2           <none>          24m

NAMESPACE     NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns              2/2     2            2           24m
kube-system   deployment.apps/coredns-autoscaler   1/1     1            1           24m
kube-system   deployment.apps/konnectivity-agent   2/2     2            2           24m
kube-system   deployment.apps/metrics-server       2/2     2            2           24m

NAMESPACE     NAME                                            DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-789789675               2         2         2       24m
kube-system   replicaset.apps/coredns-autoscaler-649b947bbd   1         1         1       24m
kube-system   replicaset.apps/konnectivity-agent-6c6b9bfc8b   2         2         2       14m
kube-system   replicaset.apps/konnectivity-agent-7dc986dbcc   0         0         0       24m
kube-system   replicaset.apps/metrics-server-5955767688       2         2         2       23m
kube-system   replicaset.apps/metrics-server-7557c5798        0         0         0       24m

k create ns tuplus

➜  k apply -f azure-registry-secret.yaml
secret/azure-registry-secret created
bm in security/secret on  feature [✘?] 
➜  k apply -f azure-storage-secret.yaml
secret/storage-azure-secret created
bm in security/secret on  feature [✘?] 
➜  k get secrets -A
NAMESPACE     NAME                     TYPE                             DATA   AGE
kube-system   bootstrap-token-f17gvd   bootstrap.kubernetes.io/token    4      28h
kube-system   konnectivity-certs       Opaque                           3      28h
tuplus        azure-registry-secret    kubernetes.io/dockerconfigjson   1      32s
tuplus        storage-azure-secret     Opaque                           2      20s

아르고 설치


```