clear
echo -en "\033[37;1;41m Устанавливаем Kiali \033[0m\n"
echo "Kiali - доска управления Service mesh"
echo "Добавить репозиторий в Helm:"
helm repo add kiali https://kiali.org/helm-charts
helm repo update

echo "Установить Kiali Operator, разворачивающий Kiali"
helm install --version "1.33.1" -n kiali-operator -f kiali/operator-values.yaml kiali-operator kiali/kiali-operator

echo "Развернуть Kiali:"
kubectl apply -f kiali/kiali.yaml
sllep 5
echo "Проверить состояние Kiali:"
kubectl get po -n kiali -l app.kubernetes.io/name=kiali

echo "Открыть web-интерфейс Kiali:"
minikube service -n kiali kiali-nodeport