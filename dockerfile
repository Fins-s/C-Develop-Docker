FROM linuxserver/code-server

ARG CMKAE_VERSION=3.29.7
ARG GTEST_VERSION=1.15.2

RUN ARCH=$(uname -m) &&\
    apt-get update &&\
    apt-get upgrade -y &&\
    # gcc wget g++ make python3 pip
    apt-get install -y wget gcc g++ gdb make git python3 python3-pip &&\
    mkdir /temp &&\
    # install cmake
    wget -P /temp https://github.com/Kitware/CMake/releases/download/v${CMKAE_VERSION}/cmake-${CMKAE_VERSION}-linux-x86_64.sh &&\
    chmod +x /temp/cmake-${CMKAE_VERSION}-linux-x86_64.sh &&\
    /temp/cmake-${CMKAE_VERSION}-linux-x86_64.sh --skip-license --prefix=/usr/local &&\
    # install gtest
    wget -P /temp https://github.com/google/googletest/archive/refs/tags/v${GTEST_VERSION}.tar.gz &&\
    tar -xzf /temp/v${GTEST_VERSION}.tar.gz -C /temp &&\
    cd /temp/googletest-${GTEST_VERSION} &&\
    cmake -S . -B ./build &&\
    cd ./build &&\
    make &&\
    make install &&\
    # clean
    rm -rf /temp &&\
    apt-get clean

# apt-get autoremove -y &&\

# build: docker build -t finsss/c-develop-docker:latest .
# deploy: docker-compose up -d
# push: docker push finsss/c-develop-docker:latest 