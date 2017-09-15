FROM dhermes/flang03

# Clone ``openmp-llvm`` and build
RUN cd openmp/runtime \
  && git checkout release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(nproc) \
  && sudo make install
