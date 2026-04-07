const std = @import("std");

/// Minimal macOS SDK headers for cross-compilation
/// Extracted from Xcode for building c-ares and other packages
/// that require SystemConfiguration and notify APIs
pub fn build(b: *std.Build) void {
    _ = b;
    // This is a header-only package
    // Other packages use the paths from this dependency for include directories
}

/// Get the root path of this SDK package
pub fn getRootPath() []const u8 {
    return comptime blk: {
        const root = std.fs.path.dirname(@src().file) orelse ".";
        break :blk root;
    };
}

/// Add SDK include paths to a compile step
pub fn addIncludePaths(step: *std.Build.Step.Compile) void {
    const root = getRootPath();
    
    // Standard usr/include path
    step.addSystemIncludePath(.{ .cwd_relative = root ++ "/usr/include" });
    
    // Framework paths
    step.addSystemFrameworkPath(.{ .cwd_relative = root ++ "/System/Library/Frameworks" });
    step.addSystemIncludePath(.{ .cwd_relative = root ++ "/System/Library/Frameworks/SystemConfiguration.framework/Versions/A/Headers" });
    step.addSystemIncludePath(.{ .cwd_relative = root ++ "/System/Library/Frameworks/CoreFoundation.framework/Versions/A/Headers" });
}
