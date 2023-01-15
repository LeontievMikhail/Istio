echo -en "\n\033[32m Start minikube\n"
#minikube start --driver docker --cpus=4 --memory=4g  --kubernetes-version="v1.19.0"
minikube start --disk-size=40g --cpus=4 --memory=8g --driver=virtualbox --listen-address=0.0.0.0 --kubernetes-version="v1.19.0"
minikube addons enable metrics-server


###minikube start --driver docker --cpus=4 --memory=4g --cni=flannel --kubernetes-version="v1.19.0" 

# --apiserver-ips=192.168.1.121
# Указать явный адрес от сервервера для minikube