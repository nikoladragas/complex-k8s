docker build -t 1608996/complex-client:latest -t 1608996/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 1608996/complex-server:latest -t 1608996/multi-server:$SHA -f ./server/Dockerfile  ./server
docker build -t 1608996/complex-worker:latest -t 1608996/multi-worker:$SHA -f ./worker/Dockerfile  ./worker
docker push 1608996/complex-client:latest
docker push 1608996/complex-server:latest
docker push 1608996/complex-worker:latest

docker push 1608996/complex-client:$SHA
docker push 1608996/complex-server:$SHA
docker push 1608996/complex-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=1608996/complex-server:$SHA
kubectl set image deployments/client-deployment client=1608996/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=1608996/complex-worker:$SHA