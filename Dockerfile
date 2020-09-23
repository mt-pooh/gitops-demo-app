FROM golang:1.14 as builder

WORKDIR /app
COPY . /app/

RUN go get github.com/gin-gonic/gin
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags="-s -w" -installsuffix cgo -o hello main.go

FROM alpine:3.12

COPY --from=builder /app/hello /bin/hello
COPY --from=builder /app/templates/ /app/templates/
WORKDIR /app

ARG COMMIT_HASH="null"

# COMMIT_HASH変数を環境変数に設定
ENV COMMIT_HASH ${COMMIT_HASH}

EXPOSE 8080

CMD /bin/hello ${COMMIT_HASH}
