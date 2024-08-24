mkdir build
cd build

cmake ${CMAKE_ARGS} -G Ninja ..

cmake --build . --config Release -- -j$CPU_COUNT
cmake --build . --config Release --target install

cd ..

$PYTHON -m pip install . -vv --no-build-isolation
