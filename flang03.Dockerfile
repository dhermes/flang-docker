FROM dhermes/flang02

# Clone the ``clang`` modified by ``flang`` and build
RUN cd clang \
  && git checkout flang_release_40 \
  && mkdir build && cd build \
  && cmake .. \
  && make --jobs $(nproc) \
  && make install
