FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

# Pinned "release"
ENV FLANG_RELEASE c125e8e34fd6b7b45edb2376bf0f81f70847beba

# Make sure package manager and install build-tools
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    cmake \
    python \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -f /var/cache/apt/archives/*.deb

# Clone all source that we'll end up using.
RUN git clone https://github.com/llvm-mirror/llvm.git
RUN git clone https://github.com/flang-compiler/clang.git
RUN git clone https://github.com/llvm-mirror/openmp.git
RUN git clone https://github.com/flang-compiler/flang.git
