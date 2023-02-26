# FROM alpine:latest

# RUN apk add --update-cache \
#     wget \
#     ca-certificates \
#     bash \
#     curl \
#     jq  \
#     && rm -rf /var/cache/apk/*

FROM ubuntu:20.04

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y curl \
  && apt-get install -y jq \
  && apt-get install -y ca-certificates \
  && rm -rf /var/lib/apt/lists/*




ARG ARTIFACT_BIN
ARG ARTIFACT_LINK
ARG INSTALL_DIR="/root"
# ENV NIBIRU_MONIKER="your_name"
# ENV NIBIRU_CHAIN="nibiru-testnet-2"
# ENV NIBIRU_WALLET="your_name"


WORKDIR /root

RUN wget  $ARTIFACT_LINK  && tar -zxvf $ARTIFACT_BIN --directory $INSTALL_DIR && rm $ARTIFACT_BIN

RUN if [ -f nibirud ]; then \
        mv nibirud nibid ; \
    fi

COPY bootstrap.sh ./
#COPY test.sh ./


RUN mv nibid /usr/local/bin/nibid  && chmod +x bootstrap.sh && ./bootstrap.sh

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini


ENTRYPOINT ["/tini", "--"]

# ENTRYPOINT ["bash"]

CMD []
