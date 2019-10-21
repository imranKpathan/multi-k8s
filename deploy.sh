docker build -t imrankpathan/multi-container-client:latest -t imrankpathan/multi-container-client:$SHA -f ./client/Dockerfile ./client
docker build -t imrankpathan/multi-container-server:latest -t imrankpathan/multi-container-server:$SHA -f ./server/Dockerfile ./server
docker build -t imrankpathan/multi-container-worker:latest -t imrankpathan/multi-container-worker:$SHA -f ./worker/Dockerfile ./worker

docker push imrankpathan/multi-container-client:latest
docker push imrankpathan/multi-container-server:latest
docker push imrankpathan/multi-container-worker:latest

docker push imrankpathan/multi-container-client:$SHA
docker push imrankpathan/multi-container-server:$SHA
docker push imrankpathan/multi-container-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=imrankpathan/multi-container-client:$SHA
kubectl set image deployments/server-deployment server=imrankpathan/multi-container-server:$SHA
kubectl set image deployments/worker-deployment worker=imrankpathan/multi-container-worker:$SHA