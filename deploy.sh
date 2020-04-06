docker build -t loesakb/multi-client:latest -t loesakb/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t loesakb/multi-server:latest -t loesakb/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t loesakb/multi-worker:latest -t loesakb/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push loesakb/multi-client:latest
docker push loesakb/multi-server:latest
docker push loesakb/multi-worker:latest

docker push loesakb/multi-client:$SHA
docker push loesakb/multi-server:$SHA
docker push loesakb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=loesakb/multi-server:$SHA
kubectl set image deployments/client-deployment server=loesakb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=loesakb/multi-worker:$SHA