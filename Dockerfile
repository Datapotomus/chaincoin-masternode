FROM  ubuntu:14.04

# global environment settings
WORKDIR /usr/src

# Exposing ports
EXPOSE 8333 11994



# install packages
RUN \
 apt-get update && \
 apt-get install -y \
 automake \
 libdb++-dev \
 build-essential \
 libtool \
 autotools-dev \
 autoconf \
 pkg-config \
 libssl-dev \
 libboost-all-dev \
 libminiupnpc-dev \
 libevent-dev \
 git \
 software-properties-common \
 python-software-properties \
 g++ \
 bsdmainutils

# Download and compile Berkely DB, frankly don't know why this is seperate, but im following everyone else.
 RUN add-apt-repository ppa:bitcoin/bitcoin -y
 RUN apt-get update
 RUN apt-get install libdb4.8-dev libdb4.8++-dev -y

# Pulls software from github
 RUN git clone https://github.com/chaincoin/chaincoin.git


