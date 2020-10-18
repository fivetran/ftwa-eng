#!/bin/bash
set -euo pipefail
set -x

bazel build //:binary_deploy.jar
cp Dockerfile bazel-bin/Dockerfile
docker build -t gcr.io/sandbox-testing-215308/libdontdie_base:test -f bazel-bin/Dockerfile bazel-bin/
docker push gcr.io/sandbox-testing-215308/libdontdie_base:test