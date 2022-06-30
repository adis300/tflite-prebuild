# tflite-prebuild
Prebuild tflite for many platforms.

# Makesure bazel >= 5.1 is installed
choco install bazel --version=5.1.1


# MacOS
brew tap bazelbuild/tap
brew extract bazel bazelbuild/tap --version 5.1.1
brew install bazel@5.1.1

brew unlink bazel
brew link bazel@5.1.1

# Android
make sure only install NDK 21.xxx

# All conditions
bazel query --output=build @cpuinfo//:android_arm64

Conditions checked:
 @cpuinfo//:linux_x86_64
 @cpuinfo//:linux_arm
 @cpuinfo//:linux_armhf
 @cpuinfo//:linux_armv7a
 @cpuinfo//:linux_armeabi
 @cpuinfo//:linux_aarch64
 @cpuinfo//:linux_mips64
 @cpuinfo//:linux_riscv64
 @cpuinfo//:linux_s390x
 @cpuinfo//:linux_ppc64le
 @cpuinfo//:macos_x86_64
 @cpuinfo//:macos_arm64
 @cpuinfo//:windows_x86_64
 @cpuinfo//:android_armv7   (armeabi-v7a)
 @cpuinfo//:android_arm64   (arm64-v8a)
 @cpuinfo//:android_x86     (x86)
 @cpuinfo//:android_x86_64  (x86_64)
 @cpuinfo//:ios_x86_64
 @cpuinfo//:ios_x86
 @cpuinfo//:ios_armv7
 @cpuinfo//:ios_arm64
 @cpuinfo//:ios_arm64e
 @cpuinfo//:ios_sim_arm64
 @cpuinfo//:watchos_x86_64
 @cpuinfo//:watchos_x86
 @cpuinfo//:watchos_armv7k
 @cpuinfo//:watchos_arm64_32
 @cpuinfo//:tvos_x86_64
 @cpuinfo//:tvos_arm64
 @cpuinfo//:emscripten_wasm