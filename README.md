CodeHz's node image
===
A Experiment to build world's most minimalist node image.

Usage:
```Dockerfile
FROM codehz/node:latest AS builder

WORKDIR /build/app
ADD . /build/app
RUN npm i --unsafe-perm && npm prune
RUN /packager.sh -d /usr/bin/node /build

FROM scratch

COPY --from=builder /build /
```