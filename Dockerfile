FROM golang:alpine AS build-env

# Set up dependencies
ENV PACKAGES git build-base

# Set working directory for the build
WORKDIR /go/src/github.com/mara-labs/mara-chain

# Install dependencies
RUN apk add --update $PACKAGES
RUN apk add linux-headers

# Add source files
COPY . .

# Make the binary
RUN make build

# Final image
FROM alpine:3.16.2

# Install ca-certificates
RUN apk add --update ca-certificates jq
WORKDIR /

# Copy over binaries from the build-env
COPY --from=build-env /go/src/github.com/mara-labs/mara-chain/build/marad /usr/bin/marad

# Run marad by default
CMD ["marad"]
