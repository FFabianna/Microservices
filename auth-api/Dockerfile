# Use the official Go image as a base image
FROM golang:1.22

WORKDIR /usr/src/app
COPY . .
# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
ENV GO111MODULE=on
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
RUN go mod tidy
RUN go build
# Expose port 8000 to the outside world
EXPOSE 8000

# Set environment variables
ENV JWT_SECRET=PRFT
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://usersapi:8083
CMD ["./auth-api"]