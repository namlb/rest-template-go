# syntax=docker/dockerfile:1

FROM golang:1.19

WORKDIR /app
COPY ./ ./
ENV POSTGRES_DSN="postgresql://guest:guest@postgres:5432/speakeasy?sslmode=disable"
ENV SPEAKEASY_ENVIRONMENT=docker
RUN go mod download
RUN go build ./cmd/server/main.go
CMD ["./main"]