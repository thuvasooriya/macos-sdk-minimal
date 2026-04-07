# Minimal macOS SDK for Cross-Compilation

This package provides a minimal set of macOS SDK headers needed for cross-compiling software that requires SystemConfiguration and notify APIs.

## Purpose

When cross-compiling from Linux/Windows to macOS, the macOS SDK headers (like `notify.h` and `SystemConfiguration/SCNetworkConfiguration.h`) are not available. This package provides those headers so that software like c-ares can be built with full functionality.

## Contents

- `notify.h` - System notification APIs
- `SystemConfiguration.framework` - Network configuration APIs
- `CoreFoundation.framework` - Base types for SystemConfiguration
- Supporting headers (sys/cdefs.h, os/availability.h, etc.)

## Usage

Add to your `build.zig.zon`:

```zig
.macos_sdk_minimal = .{
    .url = "git+https://github.com/thuvasooriya/macos-sdk-minimal.git#main",
    .hash = "...",
    .lazy = true,
},
```

In your `build.zig`:

```zig
const macos_sdk = b.dependency("macos_sdk_minimal", .{});
const lib = b.addLibrary(...);

// Add SDK paths
lib.addSystemIncludePath(macos_sdk.path("usr/include"));
lib.addSystemFrameworkPath(macos_sdk.path("System/Library/Frameworks"));
```

## License

These headers are from the Apple Xcode SDK and are subject to the Apple Public Source License (APSL). See individual header files for license terms.

This packaging work (build.zig, build.zig.zon) is MIT licensed.
