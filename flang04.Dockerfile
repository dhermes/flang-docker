FROM dhermes/flang03

# Clone ``openmp-llvm`` and build
RUN cd openmp/runtime \
  && git checkout release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(($(nproc) > 1 ? $(expr $(nproc) / 2) : 1)) \
  && make install
