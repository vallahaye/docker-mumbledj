FROM golang:1 AS builder

ENV MUMBLEDJ_VERSION 3.2.1

WORKDIR /go/src/github.com/matthieugrieger/mumbledj

RUN set -x \
    \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y libopus-dev wget \
    && wget -O- "https://github.com/matthieugrieger/mumbledj/archive/v${MUMBLEDJ_VERSION}.tar.gz" | tar xzf - --strip-components=1 \
    && go install ./...

FROM debian:stable-slim

LABEL maintainer="Valentin Lahaye <valentin.lahaye@gmail.com>"

COPY --from=builder /go/bin/mumbledj /usr/local/bin/mumbledj
COPY --from=builder /go/src/github.com/matthieugrieger/mumbledj/config.yaml /root/.config/mumbledj/config.yaml

RUN set -x \
    \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y ca-certificates aria2 ffmpeg python wget \
    && wget "https://yt-dl.org/downloads/latest/youtube-dl" -O /usr/local/bin/youtube-dl \
    && chmod a+rx /usr/local/bin/youtube-dl \
    && apt-get remove --purge --auto-remove -y wget && rm -rf /var/lib/apt/lists/* \
    && mkdir /docker-entrypoint.d

COPY docker-entrypoint.sh /
COPY 10-update-youtube-dl.sh /docker-entrypoint.d
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["mumbledj"]
