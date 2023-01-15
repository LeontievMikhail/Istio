curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.14.3 TARGET_ARCH=x86_64 sh - 
sudo mv istio-1.14.3 /usr/local/bin/istio
export PATH="$PATH:/usr/local/bin/istio/bin"


clear
echo -en "\033[37;1;41m Разворачиваем Istio \033[0m\n"
echo "Istio - Service mesh решение для облачных платформ, использующее Envoy."
echo "Установить оператор, разворачивающий Istio:"


istioctl install --set profile=default \
  --set "values.global.proxy.resources.requests.cpu=10m" \
  --set "values.global.proxy.resources.requests.memory=100Mi" -y

### Устарело
#istioctl operator init --watchedNamespaces istio-system --operatorNamespace istio-operator
#echo "Развернуть Istio c помощью оператора:"
#kubectl apply -f istio/istio.yaml
#sleep 5
#echo "Проверить состояние Istio:"
#kubectl get all -n istio-system -l istio.io/rev=default
#
#echo "Установить настройки по-умолчанию:"
#kubectl apply -f istio/disable-mtls.yaml