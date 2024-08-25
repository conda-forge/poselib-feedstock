mkdir build
cd build

cmake ${CMAKE_ARGS} -G Ninja -DBUILD_SHARED_LIBS=ON -DPYTHON_PACKAGE=ON -DPython_EXECUTABLE=$PYTHON -DCMAKE_BUILD_TYPE=Release ..

cmake --build . --config Release -- -j$CPU_COUNT
cmake --build . --config Release --target install
