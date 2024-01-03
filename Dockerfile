# syntax=docker/dockerfile:1

FROM golang:1.19 as base
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY ./ ./
RUN go build -o app ./cmd/server/main.go

FROM base as build-server
ENV POSTGRES_DSN="postgresql://guest:guest@postgres:5432/speakeasy?sslmode=disable"
ENV SPEAKEASY_ENVIRONMENT=docker
COPY --from=base /app/app .
CMD ["./app"]