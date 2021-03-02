FROM alpine:latest

LABEL description="A small Alpine Linux image with gcc-10 and vcpkg"

# Install build dependencies
RUN apk update && apk add --no-cache cmake gcc git g++ curl make ninja

# Setup vcpkg in /vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh -useSystemBinaries \
    && ./vcpkg integrate install

ENV PATH=/vcpkg:$PATH
ENV VCPKG_ROOT=/vcpkg
