# Bazel stamping

## How to reproduce?

Script execution result (`./stamping.sh`):

```
+ bazel build :stamping --stamp
INFO: Invocation ID: 6a7b1fae-3e73-4bbf-ba19-def31e63aacf
INFO: Analyzed target //:stamping (1 packages loaded, 2 targets configured).
INFO: Found 1 target...
Target //:stamping up-to-date:
  bazel-bin/stamping.txt
INFO: Elapsed time: 0.052s, Critical Path: 0.01s
INFO: 2 processes: 1 internal, 1 linux-sandbox.
INFO: Build completed successfully, 2 total actions
+ tee pass-1.txt
719ec30162bfa4acffab4a60ee6bf906  stamping.sh
d074b6fc8dfd2cc36c052c38b255fd42  bazel-out/volatile-status.txt
+ sleep 1
+ bazel clean
INFO: Invocation ID: 47969bb8-f48d-48c9-b6ad-1ea131bafeca
INFO: Starting clean (this may take a while). Consider using --async if the clean takes more than several minutes.
+ bazel build :stamping --stamp
INFO: Invocation ID: 1d301b41-cbc8-4388-b671-710c41963cbe
INFO: Analyzed target //:stamping (4 packages loaded, 7 targets configured).
INFO: Found 1 target...
Target //:stamping up-to-date:
  bazel-bin/stamping.txt
INFO: Elapsed time: 0.129s, Critical Path: 0.01s
INFO: 2 processes: 1 internal, 1 linux-sandbox.
INFO: Build completed successfully, 2 total actions
+ tee pass-2.txt
719ec30162bfa4acffab4a60ee6bf906  stamping.sh
1817baa3841a81a8a1bca13e5839cdf4  bazel-out/volatile-status.txt
+ diff pass-1.txt pass-2.txt
2c2
< d074b6fc8dfd2cc36c052c38b255fd42  bazel-out/volatile-status.txt
---
> 1817baa3841a81a8a1bca13e5839cdf4  bazel-out/volatile-status.txt
```

## Expected result

Since the `stamping` rule only depends on the `stamping.sh` and `volatile-status.txt` files, I expect
that `volatile-status.txt` not used in cache key and I got cached `stamping.txt` content on second build.

## Actual result

File `stamping.txt` rebuilt due to `volatile-status.txt` change.
