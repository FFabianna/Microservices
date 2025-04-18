#!/bin/bash

echo "⛴️ Configurando entorno de Docker en Minikube..."
eval $(minikube docker-env)

echo "🛠️ Construyendo imágenes Docker..."
# Nombre de usuario en Docker Hub
DOCKER_USER="fabiianna"
# Crear la red si no existe
docker network create microservices-network || true
# Construir imágenes con nombres correctos
docker build -t $DOCKER_USER/redis-image ./redis
docker build -t $DOCKER_USER/zipkin-image ./zipkin
docker build -t $DOCKER_USER/log-image ./log-message-processor
docker build -t $DOCKER_USER/usersapi-image ./users-api
docker build -t $DOCKER_USER/authapi-image ./auth-api
docker build -t $DOCKER_USER/todosapi-image ./todos-api
docker build -t $DOCKER_USER/frontend-image ./frontend

docker tag $DOCKER_USER/redis-image $DOCKER_USER/redis-image:latest
docker tag $DOCKER_USER/zipkin-image $DOCKER_USER/zipkin-image:latest
docker tag $DOCKER_USER/log-image $DOCKER_USER/log-image:latest
docker tag $DOCKER_USER/usersapi-image $DOCKER_USER/usersapi-image:latest
docker tag $DOCKER_USER/authapi-image $DOCKER_USER/authapi-image:latest
docker tag $DOCKER_USER/todosapi-image $DOCKER_USER/todosapi-image:latest
docker tag $DOCKER_USER/frontend-image $DOCKER_USER/frontend-image:latest

docker push $DOCKER_USER/redis-image:latest
docker push $DOCKER_USER/zipkin-image:latest
docker push $DOCKER_USER/log-image:latest
docker push $DOCKER_USER/usersapi-image:latest
docker push $DOCKER_USER/authapi-image:latest
docker push $DOCKER_USER/todosapi-image:latest
docker push $DOCKER_USER/frontend-image:latest

echo "🚀 Aplicando configuraciones de Kubernetes..."
kubectl apply -f k8s/

echo "⏳ Esperando a que los pods estén listos..."
kubectl wait --for=condition=available --timeout=300s deployment/frontend
kubectl wait --for=condition=available --timeout=300s deployment/authapi
kubectl wait --for=condition=available --timeout=300s deployment/todosapi
kubectl wait --for=condition=available --timeout=300s deployment/usersapi
kubectl wait --for=condition=available --timeout=300s deployment/redis
kubectl wait --for=condition=available --timeout=300s deployment/zipkin

echo "🌐 Obteniendo URL del servicio Frontend..."
minikube service frontend
