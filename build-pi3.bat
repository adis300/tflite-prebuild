set SCRIPT_DIR=%cd%
set TF_SRC_DIR=%SCRIPT_DIR%\tensorflow
set BUILD_DIR=%SCRIPT_DIR%\tflite_build

cd %TF_SRC_DIR%
python configure.py
bazel build --config=elinux_armhf -c opt //tensorflow/lite/c:libtensorflowlite_c.so

RMDIR %BUILD_DIR%
MKDIR %BUILD_DIR%\pi3
MKDIR %BUILD_DIR%\include

cd %SCRIPT_DIR%
COPY %SCRIPT_DIR%\bazel-out\armhf-opt\bin\tensorflow\lite\c\*.dll %BUILD_DIR%\pi3 /Y

COPY %TF_SRC_DIR%\tensorflow\lite\c\c_api_types.h %BUILD_DIR%\include /Y
COPY %TF_SRC_DIR%\tensorflow\lite\c\c_api.h %BUILD_DIR%\include /Y
