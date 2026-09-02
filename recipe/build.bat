@echo on

mkdir build_lib
cd build_lib

cmake %CMAKE_ARGS% -G Ninja ^
               -DPYTHON_PACKAGE=OFF ^
               -DCMAKE_BUILD_TYPE=Release ^
               -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
               -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
              ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --config Release
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --config Release --target install
if %ERRORLEVEL% neq 0 exit 1

cd ..

python -m pip install . -vv --no-build-isolation --no-deps
if %ERRORLEVEL% neq 0 exit 1
