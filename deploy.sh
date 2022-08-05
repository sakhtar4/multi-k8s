#!/bin/bash

docker build -t sakhtar4/multi-client:latest -t sakhtar4/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sakhtar4/multi-server:latest -t sakhtar4/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sakhtar4/multi-worker:latest -t sakhtar4/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sakhtar4/multi-client:latest
docker push sakhtar4/multi-server:latest
docker push sakhtar4/multi-worker:latest

docker push sakhtar4/multi-client:$SHA
docker push sakhtar4/multi-server:$SHA
docker push sakhtar4/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sakhtar4/multi-server:$SHA
kubectl set image deployments/client-deployment client=sakhtar4/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sakhtar4/multi-worker:$SHA
