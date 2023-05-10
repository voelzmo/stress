FROM --platform=$BUILDPLATFORM golang:1.20.4 as builder

WORKDIR /src
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY main.go .
RUN go mod vendor

ARG TARGETOS TARGETARCH
RUN CGO_ENABLED=0 GOARCH=$TARGETARCH GOOS=$TARGETOS go build -mod vendor -o /out/stress --ldflags '-extldflags "-static"'

FROM scratch

COPY --from=builder /out/stress /

ENTRYPOINT ["/stress", "-logtostderr"]
