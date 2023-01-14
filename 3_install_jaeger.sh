clear
echo -en "\033[37;1;41m  Разворачиваем Jaeger\033[0m\n"
echo -en "\nJaeger - решение трассировки. Компоненты Istio, такие как: sidecar-контейнер, gateway, отправляют данные запросов в систему. Таким образом получается полная трассировка запроса."
echo -en "\nДобавить репозиторий в Helm:"

helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo update

echo " \nУстановить оператор, разворачивающий Jaeger:"
helm install --version "2.19.0" -n jaeger-operator -f jaeger/operator-values.yaml jaeger-operator jaegertracing/jaeger-operator

echo "\nРазвернуть Jaeger:"
kubectl apply -f jaeger/jaeger.yaml
sleep 5
echo "\nПроверить состояние Jaeger:"
kubectl get po -n jaeger -l app.kubernetes.io/instance=jaeger

echo " \nОткрыть web-интерфейс Jaeger:"
minikube service -n jaeger jaeger-query-nodeport
