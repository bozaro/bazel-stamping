#!/bin/bash -ex
bazel build :stamping --stamp
tee pass-1.txt < bazel-bin/stamping.txt
sleep 1
bazel clean
bazel build :stamping --stamp
tee pass-2.txt < bazel-bin/stamping.txt
diff pass-1.txt pass-2.txt
