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