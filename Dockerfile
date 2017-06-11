FROM ubuntu:16.10

MAINTAINER Jing Qiu <aqiu0720@gmail.com>

LABEL Description="This image is used to start a mininet env" Vendor="Jing Qiu" Version="1.0"


ENV MININET_REPO git://github.com/jingqiuELE/mininet
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
    sudo \
    autoconf \
    automake \
    ca-certificates \
    git \
    libtool \
    net-tools \
    openssh-client \
    patch \
    vim \
    iptables \

# Clone and install.
    && git clone $MININET_REPO \

# Install script expects to find this. Easier than patching that part of the script.
    && touch /.bashrc \

# Proceed with the install.
    && chmod +x $MININET_INSTALLER \
    && ./$MININET_INSTALLER -nfv \


VOLUME ["/data"]

WORKDIR /projects/tinyvpn

# Default command.
CMD ["bash"]
