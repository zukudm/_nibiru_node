FROM alpine:latest

RUN apk add --update-cache \
    wget \
    ca-certificates \
    bash \
    curl \
    jq  \
    && rm -rf /var/cache/apk/*


ARG ARTIFACT_BIN
ARG ARTIFACT_LINK

ARG INSTALL_DIR="/root"

WORKDIR /root

RUN wget  $ARTIFACT_LINK  && tar -zxvf $ARTIFACT_BIN --directory $INSTALL_DIR

RUN mv nibid /usr/local/bin


ENTRYPOINT ["bash"]
