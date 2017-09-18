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

# Clone ``llvm`` and build
RUN git clone https://github.com/llvm-mirror/llvm.git \
  && cd llvm \
  && git checkout release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(nproc) \
  && make install

# Clone the ``clang`` modified by ``flang`` and build
RUN git clone https://github.com/flang-compiler/clang.git \
  && cd clang \
  && git checkout flang_release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(nproc) \
  && make install

# Clone ``openmp-llvm`` and build
RUN git clone https://github.com/llvm-mirror/openmp.git \
  && cd openmp/runtime \
  && git checkout release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(nproc) \
  && make install

# Clone ``flang`` and build
RUN git clone https://github.com/flang-compiler/flang.git \
  && cd flang \
  && git checkout ${FLANG_RELEASE} \
  && mkdir build && cd build \
  && cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DCMAKE_Fortran_COMPILER=flang .. \
  && make --jobs $(nproc) \
  && make install
