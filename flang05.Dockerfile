FROM dhermes/flang04

# Clone ``flang`` and build
RUN cd flang \
  && git checkout ${FLANG_RELEASE} \
  && mkdir build && cd build \
  && cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DCMAKE_Fortran_COMPILER=flang .. \
  && make --jobs $(($(nproc) > 1 ? $(expr $(nproc) / 2) : 1)) \
  && make install
