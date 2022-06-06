set SCRIPT_DIR=%cd%
set TF_SRC_DIR=%SCRIPT_DIR%\tensorflow
set BUILD_DIR=%SCRIPT_DIR%\tflite_build

mkdir %BUILD_DIR%
cd %BUILD_DIR%

call cmake %TF_SRC_DIR%/tensorflow/lite -G "MinGW Makefiles"

::build\shared 
call cmake --build . -j --config Release

cd %SCRIPT_DIR%