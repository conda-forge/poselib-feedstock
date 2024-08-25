@echo on

mkdir build
cd build

cmake -G Ninja -DPYTHON_PACKAGE=ON ^
               -DPython_EXECUTABLE=%PYTHON% ^
               -DCMAKE_BUILD_TYPE=Release ^
               -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
               -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
              ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --config Release
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --config Release --target install
if %ERRORLEVEL% neq 0 exit 1
