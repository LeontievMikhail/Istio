  echo -e "\nСоздание Gateway для Proxy"
  kubectl apply -f gw/proxy-ingress-gateway.yaml 
  echo -e "\nСоздание Virtual Service для Proxy"
  kubectl apply -f gw/proxy-vs.yaml 

  minikube tunnel &

  #Открыть доступ для Minikube наружу 
  # minikube tunnel
  # or
  # firewall-cmd --add-port=8081/tcp
  # kubectl port-forward --address 0.0.0.0 services/web8080 8081:8080
  #
  # curl localhost:8081      (directly from the machine running the cluster inside a VM)
  #curl 192.168.x.xx:8081   (from my Mac in same network - this is the private ip of the machine running the cluster inside a VM)
  #curl 84.xxx.xxx.xxx:8081 (from a phone connected in 4G - this is the public ip exposed by my router)
  #
  #https://www.zepworks.com/posts/access-minikube-remotely-kvm/

#while true; do sleep 0.25; curl http://10.103.14.38?url=http://echoserver; done