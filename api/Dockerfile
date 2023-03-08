FROM golang:1.20-alpine

WORKDIR /api
COPY src/go.mod src/main.go ./
RUN go get -d -v ./...
RUN go install -v ./...
RUN go build

CMD ["./api"]