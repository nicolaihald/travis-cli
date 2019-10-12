FROM ruby:alpine

RUN apk add --no-cache build-base git && \
    gem install travis && \
    gem install travis-lint && \
    apk del build-base &&\
    mkdir workspace

WORKDIR workspace
VOLUME ["/workspace"]
ENTRYPOINT ["travis"]