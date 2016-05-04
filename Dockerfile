FROM ubuntu:14.04

MAINTAINER Ozzy Johnson <docker@ozzy.io>

LABEL Description="This image is used to start a mininet env" Vendor="Jing Qiu" Version="1.0"


ENV MININET_REPO git://github.com/mininet/mininet
ENV MININET_INSTALLER mininet/util/install.sh
ENV INSTALLER_SWITCHES -fbinptvwyx

WORKDIR /projects

# Update and install minimal.
RUN \
    apt-get update \
        --quiet \
    && apt-get install \
        --yes \
        --no-install-recommends \
        --no-install-suggests \
    autoconf \
    automake \
    ca-certificates \
    git \
    libtool \
    net-tools \
    openssh-client \
    patch \
    vim \

# Clone and install.
    && git clone $MININET_REPO \

# Install script expects to find this. Easier than patching that part of the script.
    && touch /.bashrc \

# Set the mininet tag to install to be 2.2.1
    && cd mininet; git checkout -b 2.2.1 2.2.1; cd .. \

# Proceed with the install.
    && chmod +x $MININET_INSTALLER \
    && ./$MININET_INSTALLER -nfv \


VOLUME ["/data"]

# Default command.
CMD service openvswitch-switch start; sudo mn
