@echo on

mkdir build
cd build

cmake -G Ninja -DBUILD_SHARED_LIBS=ON -DPYTHON_PACKAGE=ON -DPython_EXECUTABLE=%PYTHON% ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --config Release
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --config Release --target install
if %ERRORLEVEL% neq 0 exit 1
