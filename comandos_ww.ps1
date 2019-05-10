#Se o cliente não tiver acesso de pull criar com o script \ambientedocker\kubernetes\criarGrantLeituraServico.ps1 -NomeCliente nomedocliente-namespace-cluster

#Criar o ip public antes de executar o loadbalancer svc e alterá-lo com o ip do load balancer

##Listar grupo de recursos do AKS - Tst
az aks show --subscription "Desenvolvimento/Teste Pré-Pago" --resource-group grp_teste --name tema-tst-aks --query nodeResourceGroup -o tsv

#Criar o ip no grupo de resurcos do AKS
az network public-ip create --subscription "Desenvolvimento/Teste Pré-Pago" --resource-group MC_GRP_Teste_tema-tst-aks_eastus2 --name tema-myinvest-tst-public-ip --allocation-method static

#Listar os ips
az network public-ip show --subscription "Desenvolvimento/Teste Pré-Pago" --resource-group MC_GRP_Teste_tema-tst-aks_eastus2 --name tema-myinvest-tst-public-ip --query ipAddress --output tsv

#Para criar com o helm no ambiente de tst
helm install .\myinvest --namespace=tema-tst-myinvest --name tstmyinvest -f .\tema-tst-aks-values.yaml --kube-context tema-tst-aks

#Trocar a versão do sistema do myinvest
helm upgrade tstmyinvest .\myinvest  --set=images.myinvest=latest --kube-context tema-tst-aks

#Para testar o chart
helm install .\myinvest --dry-run --debug --namespace=tema-myinvest --name tstmyinvest -f .\tema-tst-aks-values.yaml --kube-context tema-tst-aks
