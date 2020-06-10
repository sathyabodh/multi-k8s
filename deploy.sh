docker build -t sathyabodh/multi-client:latest -t sathyabodh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sathyabodh/multi-server:latest -t sathyabodh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sathyabodh/multi-worker:latest  -t sathyabodh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sathyabodh/multi-client:latest
docker push sathyabodh/multi-server:latest
docker push sathyabodh/multi-worker:latest

docker push sathyabodh/multi-client:$SHA
docker push sathyabodh/multi-server:$SHA
docker push sathyabodh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=sathyabodh/multi-server:$SHA
kubectl set image deployment/client-deployment client=sathyabodh/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=sathyabodh/multi-worker:$SHA

