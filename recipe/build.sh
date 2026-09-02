#!/bin/bash
set -euxo pipefail

# Build and install the standalone C++ library, headers and CMake config.
# (PYTHON_PACKAGE=OFF keeps this pass free of pybind11/stubgen concerns.)
mkdir build_lib
pushd build_lib
cmake ${CMAKE_ARGS} -GNinja \
    -DBUILD_SHARED_LIBS=ON \
    -DPYTHON_PACKAGE=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    ..
cmake --build . -- -j"${CPU_COUNT}"
cmake --build . --target install
popd

# Build and install the Python bindings via pip so the package layout
# (poselib/__init__.py + poselib/_core*.so + dist-info) is assembled correctly.
EXTRA_CMAKE_ARGS=""
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" ]]; then
    # pybind11-stubgen must import the freshly built extension to introspect
    # it; when cross-compiling, the build-platform interpreter cannot load a
    # target-arch module, so stub generation is impossible and must be skipped.
    EXTRA_CMAKE_ARGS="-DGENERATE_STUBS=OFF"
fi
CMAKE_ARGS="${CMAKE_ARGS} ${EXTRA_CMAKE_ARGS}" python -m pip install . -vv --no-build-isolation --no-deps
