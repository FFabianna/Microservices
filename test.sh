#!/bin/bash

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

# Ejecutar contenedores en orden
docker run -d --name redis --network microservices-network -p 6379:6379 $DOCKER_USER/redis-image
docker run -d --name zipkin --network microservices-network -p 9411:9411 $DOCKER_USER/zipkin-image
docker run -d --name log --network microservices-network -p 6029:6029 $DOCKER_USER/log-image
docker run -d --name usersapi --network microservices-network -p 8083:8083 $DOCKER_USER/usersapi-image
docker run -d --name authapi --network microservices-network -p 8000:8000 $DOCKER_USER/authapi-image
docker run -d --name todosapi --network microservices-network -p 8082:8082 $DOCKER_USER/todosapi-image
docker run -d --name frontendapi --network microservices-network -p 8080:8080 $DOCKER_USER/frontend-image




