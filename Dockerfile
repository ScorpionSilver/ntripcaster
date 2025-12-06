FROM debian:trixie-slim AS builder

COPY ntripcaster /temp

WORKDIR /temp

RUN apt-get update && apt-get install build-essential --assume-yes

RUN ./configure --prefix=/ntripcaster

RUN make install

# The builder image is dumped and a fresh image is used
# just with the built binary, config and logs made from 'make install'
FROM debian:trixie-slim
COPY --from=builder /ntripcaster/ /ntripcaster/

EXPOSE 2101

WORKDIR /ntripcaster/logs
CMD /ntripcaster/bin/casterwatch 