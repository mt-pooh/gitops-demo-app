FROM golang:1.14 as builder

WORKDIR /app
COPY . /app/

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags="-s -w" -installsuffix cgo -o main main.go

FROM alpine:3.12
LABEL maintaner="Koki Muguruma <koki_muguruma@forcia.com>"

COPY . .
COPY --from=builder /app/main /bin/main

RUN ln -sf config/config.prod.json config.json

EXPOSE 8080

CMD ["/bin/main"]
