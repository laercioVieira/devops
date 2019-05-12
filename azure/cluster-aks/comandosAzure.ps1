# 1. Passo
# Criar o ip public antes de executar o loadbalancer svc e alterá-lo com o ip do load balancer

# Listar grupo de recursos do AKS - Tst
az aks show --subscription "mySubscription" --resource-group <myResourceGroup> --name <myClusterName> --query nodeResourceGroup -o tsv

# 2. Pegar o retorno com o nome do grupo de recurso do AKS e Criar o IP
az network public-ip create --subscription "mySubscription" --resource-group <myResourceGroupAKSCluster> --name tst-myapp-public-ip --allocation-method static

# 3. Listar os ips que acabaram se ser criados
az network public-ip show --subscription "mySubscription" --resource-group <myResourceGroupAKSCluster> --name tst-myapp-public-ip --query ipAddress --output tsv

# 4. Criar com o helm um ambiente de tst a partir dos arquivos de template utilizando o arquivo com as Variaveis (-values.yaml)
helm install .\myApp --namespace=tst-myapp --name TstMyApp -f .\myApp-tst-values.yaml --kube-context <myClusterName>

# 5. Para Trocar a versão do sistema myApp, sobescrevendo o valor da variavel do arquivo values.yaml
helm upgrade TstMyApp .\myApp  --set=images.myApp=latest --kube-context <myClusterName>

# 6. Para atualizar no cluster após alguma alteração nos arquivos de template e values
helm upgrade TstMyApp .\myApp --kube-context <myClusterName>

# 7. Para testar o chart
helm install .\myApp --dry-run --debug --namespace=tst-myapp --name TstMyApp -f .\myApp-tst-values.yaml --kube-context <myClusterName>
