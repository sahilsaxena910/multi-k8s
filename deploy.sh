docker build -t sahilsaxena91096/multi-client:latest -t sahilsaxena91096/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sahilsaxena91096/multi-server:latest -t sahilsaxena91096/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sahilsaxena91096/multi-worker:latest -t sahilsaxena91096/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sahilsaxena91096/multi-client:latest
docker push sahilsaxena91096/multi-server:latest
docker push sahilsaxena91096/multi-worker:latest

docker push sahilsaxena91096/multi-client:$SHA
docker push sahilsaxena91096/multi-server:$SHA
docker push sahilsaxena91096/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=sahilsaxena91096/multi-client:$SHA
kubectl set image deployments/server-deployment server=sahilsaxena91096/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sahilsaxena91096/multi-worker:$SHA
