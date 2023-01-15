clear
echo -en "\033[37;1;41m Приложение Echoserver \033[0m\n"
echo -en "Echoserver - сервис, отдающий в виде текста параметры входящего HTTP запроса.\n\n"
echo -en "Собрать Docker-образ:\n\n"
eval $(minikube docker-env) && docker build -t proxy-app:latest -f app/src/Dockerfile app/src
echo
echo "Развернуть приложение `echoserver` в кластере:"
kubectl apply -f app/echoserver.yaml
sleep 3
echo "Проверить статус echoserver:"
kubectl get po -l "app=echoserver"

echo "Выполнить запрос к сервису:"
curl $(minikube service echoserver --url)

echo -e "\nProxy-app - сервис, умеющий запрашивать другие запросы по query-параметру url."
echo -e "\nРазвернуть приложение proxy-app в кластере:"
kubectl apply -f app/proxy-app.yaml
sleep 3
echo -e "\nПроверить статус приложения:"
kubectl get po -l "app=proxy-app"

echo -e "\nВыполнить запрос к сервису:"
curl $(minikube service proxy-app --url)

echo -e "\nПосмотреть логи приложения:"
kubectl logs -l app=proxy-app -c proxy-app
#sleep 5
#echo -e "\n\nПодадим на сервер нагрузку"
#while true; do curl "$(minikube service proxy-app --url)?url=http://echoserver"; done

#Не забудь добавить Лейбл и удалить старые поды#
#kubectl label namespace  default istio-injection=enabled
#kubectl delete po --all -n default     
