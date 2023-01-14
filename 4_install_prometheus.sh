clear
echo -en "\033[37;1;41m Разворачиваем Prometheus \033[0m\n"
echo "\nPrometheus - система мониторинга. С помощью неё собираются метрики Service mesh."

echo "\nДобавить репозиторий в Helm:"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update

echo "\nРазвернуть решение по мониторингу на основе Prometheus:"
helm install --version "13.7.2" -n monitoring -f prometheus/operator-values.yaml prometheus \
prometheus-community/kube-prometheus-stack

echo "\nПроверить состояние компонентов мониторинга:"
kubectl get po -n monitoring

echo "\nДобавить сервис типа NodePort для прямого доступа к Prometheus и Grafana:"
kubectl apply -f prometheus/monitoring-nodeport.yaml

echo "\nОткрыть web-интерфейс Grafana:"
minikube service -n monitoring prometheus-grafana-nodeport

echo "\nОткрыть web-интерфейс Prometheus:"
minikube service -n monitoring prom-prometheus-nodeport
