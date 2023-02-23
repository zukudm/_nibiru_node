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
ARG NIBIRU_MONIKER="your_name"
ARG NIBIRU_CHAIN="nibiru-testnet-2"
ARG NIBIRU_WALLET="your_name"

WORKDIR /root

RUN wget  $ARTIFACT_LINK  && tar -zxvf $ARTIFACT_BIN --directory $INSTALL_DIR && rm $ARTIFACT_BIN

RUN if [ -f nibirud ]; then \
        mv nibirud nibid ; \
    fi

COPY bootstrap.sh ./
COPY test.sh ./


# RUN mv nibid /usr/local/bin/nibid  && chmod +x bootstrap.sh && ./bootstrap.sh



ENTRYPOINT ["bash"]
