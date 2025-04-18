FROM node:8.17.0

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo package.json y package-lock.json (si existe)
COPY . .

# Instalar las dependencias
RUN npm install

ENV AUTH_API_ADDRESS=http://authapi:8000
ENV TODOS_API_ADDRESS=http://todosapi:8082

ENV TODO_API_PORT=8082
ENV JWT_SECRET=PRFT
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel
EXPOSE ${TODO_API_PORT}

CMD ["npm", "start"]