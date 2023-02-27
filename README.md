# GoLang stamping example

## Examples of running the command

### Native `go build`

Command:

```sh
go run -buildvcs=true ./example
```

Output:

```text
Stamping example
=== Begin build info ===
go	go1.20.1
path	github.com/bozaro/bazel-stamping/example
mod	github.com/bozaro/bazel-stamping	(devel)
build	-buildmode=exe
build	-compiler=gc
build	CGO_ENABLED=1
build	CGO_CFLAGS=
build	CGO_CPPFLAGS=
build	CGO_CXXFLAGS=
build	CGO_LDFLAGS=
build	GOARCH=amd64
build	GOOS=linux
build	GOAMD64=v1
build	vcs=git
build	vcs.revision=daa3fb74938a476db8bf4b295b01317226780a75
build	vcs.time=2023-02-10T17:03:08Z
build	vcs.modified=true

=== End build info ===
Found go build revision: daa3fb74938a476db8bf4b295b01317226780a75
Found go build timestamp: 2023-02-10T17:03:08Z
```

### Bazel without stamping

Command:

```shell
bazel run //example
```

Output:

```text
Stamping example
```

### Bazel with stamping

Command:

```shell
bazel run --stamp //example
```

Output:

```text
Stamping example
=== Begin build info ===
go	go1.20.1 X:nocoverageredesign
build	vcs.revision=f529d5877d4963ef5964363615b48cf066b8f1ef
build	vcs.time=2023-01-01T00:00:00Z

=== End build info ===
Found go build revision: f529d5877d4963ef5964363615b48cf066b8f1ef
Found go build timestamp: 2023-01-01T00:00:00Z
Found x_defs revision: f529d5877d4963ef5964363615b48cf066b8f1ef
Found x_defs build timestamp: 2023-02-27T06:26:16Z
```

### Bazel with stamping remote cache issue

Commands to reproduce the remote cache issue:

```shell
# First execution
bazel run --stamp --disk_cache=/tmp/bazel-disk-cache //example
# Build without stamping to invalidate local action cache
bazel build --disk_cache=/tmp/bazel-disk-cache //example
# Second execution
bazel run --stamp --disk_cache=/tmp/bazel-disk-cache //example
```
