FROM dhermes/flang01

# Clone ``llvm`` and build
RUN cd llvm \
  && git checkout release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(($(nproc) > 1 ? $(expr $(nproc) / 2) : 1)) \
  && make install
