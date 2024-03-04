FROM golang:alpine as builder
WORKDIR /src/app
RUN apk update && \
    apk add git && \
    go install github.com/gohugoio/hugo@v0.121.2
COPY . .
RUN go build -o serve_static
RUN hugo --minify

FROM gcr.io/distroless/base-debian12:nonroot
WORKDIR /app
COPY --from=builder /src/app/serve_static ./serve_static
COPY --from=builder /src/app/public ./public
ENTRYPOINT [ "./serve_static" ]
