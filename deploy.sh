docker build -t mreis43/multi-client:latest -t mreis43/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mreis43/multi-server:latest -t mreis43/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mreis43/multi-worker:latest -t mreis43/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mreis43/multi-client:latest
docker push mreis43/multi-server:latest
docker push mreis43/multi-worker:latest
docker push mreis43/multi-client:$SHA
docker push mreis43/multi-server:$SHA
docker push mreis43/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mreis43/multi-server:$SHA
kubectl set image deployments/client-deployment client=mreis43/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mreis43/multi-worker:$SHA

