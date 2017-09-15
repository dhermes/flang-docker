# `flang-docker`

Dockerfile for building [`flang`][1] on Linux. `flang` is an
LLVM-based Fortran compiler.

Since `flang` has no official releases (as of September 14, 2017) I
will [pin][2] to a specific commit in the Docker file.

[1]: https://github.com/flang-compiler/flang
[2]: https://github.com/flang-compiler/flang/commit/c125e8e34fd6b7b45edb2376bf0f81f70847beba

## Stages

- `01`: Just basic Ubuntu dependencies (Completed)
- `02`: Build and install `llvm`
- `03`: Build and install a `clang` modified for `flang`
- `04`: Build and install `openmp-llvm`
- `05`: Build and install `flang`
