load("@rules_java//java:defs.bzl", "java_binary", "java_library")

package(default_visibility = ["//visibility:public"])

java_library(
    name = "main",
    srcs = glob(["src/main/java/com/example/myproject/*.java"]),
    visibility = ["//visibility:public"],
    deps = [
        "@maven//:jakarta_ws_rs_jakarta_ws_rs_api",
        "@maven//:org_glassfish_jersey_inject_jersey_hk2",
        "@maven//:org_glassfish_jersey_core_jersey_client",
            ],
)
java_binary(
    name = "binary",
    main_class = "com.example.myproject.App",
    runtime_deps = [":main"],
)

load("@io_bazel_rules_docker//java:image.bzl", "java_image")
load("@io_bazel_rules_docker//container:push.bzl", "container_push")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")

### docker image build
java_image(
    name = "docker_image",
    base = "@java_8_base//image",
    jvm_flags = [],
    main_class = "com.example.myproject.App",
    tags = ["manual"],
    runtime_deps = [
        ":main",
    ],
)

container_image(
    name = "docker_image_with_creation_time",
    base = ":docker_image",
    stamp = True,
    symlinks = {
        "/usr/bin": "/usr/local/openjdk-8/bin",
    },
    tags = ["manual"],
)

container_push(
    name = "push_container",
    format = "Docker",
    image = ":docker_image_with_creation_time",
    registry = "gcr.io",
    repository = "sandbox-testing-215308/ftwa-infra",
    tag = "$(tag_name)",
    tags = ["manual"],
)

# bazel run //:push_container  --define tag_name=<your name>
# docker pull gcr.io/fivetran-wild-west/ftwa-infra:<your name>
# docker inspect gcr.io/fivetran-wild-west/ftwa-infra:<your name>
# docker run -d --name test-container -t gcr.io/sandbox-testing-215308/ftwa-infra:<your name>
# docker ps
# docker logs test-container
# docker stop test-container
# docker rm test-container