FROM alpine:latest

LABEL description="A small Alpine Linux image with gcc-10 and vcpkg"
LABEL maintainer="adam@adamgetchell.org"

# Install build dependencies
RUN apk update && apk upgrade \
    && apk add --no-cache build-base curl zip unzip tar openssl-dev curl-dev \
    && apk add --no-cache g++ wget libxml2-dev make ninja gcc cmake git

# Setup vcpkg in /vcpkg
RUN git clone https://github.com/microsoft/vcpkg

RUN ./vcpkg/bootstrap-vcpkg.sh -useSystemBinaries \
    && ./vcpkg/vcpkg integrate install

# Test run by downloading and running CDT-plusplus

RUN git clone https://github.com/acgetchell/CDT-plusplus.git

RUN cd CDT-plusplus && ../vcpkg/vcpkg install --feature-flags=manifests \
    && cmake -G Ninja -D CMAKE_BUILD_TYPE=Release -D ENABLE_TESTING:BOOL=FALSE -D ENABLE_IPO=ON -S . -B build \
    && cmake --build build

ENV PATH=/vcpkg:$PATH
ENV VCPKG_ROOT=/vcpkg
ENV VCPKG_FORCE_SYSTEM_BINARIES=1
