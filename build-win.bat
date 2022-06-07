set SCRIPT_DIR=%cd%
set TF_SRC_DIR=%SCRIPT_DIR%\tensorflow
set BUILD_DIR=%SCRIPT_DIR%\tflite_build

cd %TF_SRC_DIR%
python configure.py
bazel build //tensorflow/lite/c:tensorflowlite_c.dll -c opt

RMDIR %BUILD_DIR%
MKDIR %BUILD_DIR%\win
MKDIR %BUILD_DIR%\include

XCOPY 
cd %SCRIPT_DIR%
COPY %SCRIPT_DIR%\bazel-out\x64_windows-opt\bin\tensorflow\lite\c\*.dll %BUILD_DIR%\win /Y

COPY %TF_SRC_DIR%\tensorflow\lite\c\c_api_types.h %BUILD_DIR%\include /Y
COPY %TF_SRC_DIR%\tensorflow\lite\c\c_api.h %BUILD_DIR%\include /Y

