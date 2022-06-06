set SCRIPT_DIR=%cd%
set TF_SRC_DIR=%SCRIPT_DIR%\tensorflow
set BUILD_DIR=%SCRIPT_DIR%\tflite_build

cd %TF_SRC_DIR%
python configure.py
bazel build //tensorflow/lite/c:tensorflowlite_c.dll -c opt

RMDIR %BUILD_DIR%
MKDIR %BUILD_DIR%\win

XCOPY 
cd %SCRIPT_DIR%
COPY %SCRIPT_DIR%\bazel-out\x64_windows-opt\bin\tensorflow\lite\c\*.dll %BUILD_DIR%\win /Y
