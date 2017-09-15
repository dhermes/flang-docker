FROM dhermes/flang01

# Clone ``llvm`` and build
RUN cd llvm \
  && git checkout release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(nproc) \
  && sudo make install
