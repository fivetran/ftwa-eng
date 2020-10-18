#!/bin/bash
set -euo pipefail
set -x

bazel build //:binary_deploy.jar
cp Dockerfile bazel-bin/Dockerfile
cp libkeepalive-0.3.tar.gz bazel-bin/libkeepalive-0.3.tar.gz
docker build -t gcr.io/sandbox-testing-215308/libkeepalive:test -f bazel-bin/Dockerfile bazel-bin/
docker push gcr.io/sandbox-testing-215308/libkeepalive:test