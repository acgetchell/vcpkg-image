FROM ubuntu:23.04

LABEL description="A small Linux image with gcc-13 and vcpkg"
LABEL maintainer="adam@adamgetchell.org"

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=America/Los_Angeles

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    automake \
    autoconf \
    autoconf-archive \
    build-essential \
    ca-certificates \
    ccache \
    cmake \
    curl \
    g++-13 \
    git \
    libtool-bin \
    # Required to build CMake
    libssl-dev \
    ninja-build \
    pkg-config \
    tar \
    texinfo \
    # Required for date library
    tzdata \
    unzip \
    wget \
    yasm \
    zip \
    --fix-missing \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 --slave /usr/bin/g++ g++ /usr/bin/g++-13 --slave /usr/bin/gcov gcov /usr/bin/gcov-13 \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean autoclean && apt autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV CXX="g++-13"
ENV CC="gcc-13"

# Setup vcpkg in /vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh \
    # && ./vcpkg integrate install
    && cd / \
    && chmod -R 777 vcpkg

ENV PATH=/vcpkg:$PATH
ENV VCPKG_ROOT=/vcpkg
ENV VCPKG_FORCE_SYSTEM_BINARIES=0
