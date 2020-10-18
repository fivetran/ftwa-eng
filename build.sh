#!/bin/bash
set -euo pipefail
set -x

bazel build //:binary_deploy.jar
cp Dockerfile bazel-bin/Dockerfile
cp libdontdie-1.2.0.tar.xz bazel-bin/libdontdie-1.2.0.tar.xz
docker build -t gcr.io/sandbox-testing-215308/libdontdie:test -f bazel-bin/Dockerfile bazel-bin/
docker push gcr.io/sandbox-testing-215308/libdontdie:test