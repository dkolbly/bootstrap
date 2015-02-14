FROM ubuntu:14.04
MAINTAINER Donovan Kolbly <donovan@rscheme.org>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties software-properties-common git build-essential
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
RUN npm install -g grunt-cli

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /app && cp -a /tmp/node_modules /app

ADD . /app
RUN cd /app ; grunt dist

# To build this::
#   docker build -t bootstrap .
#
# To extract the resulting dist files::
#   docker run --rm -v /tmp:/out bootstrap tar czf /out/bootstrap-dist.tar.gz -C /app/dist .
