const std = @import("std");

pub fn main() void {
    const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    _ = a;
    const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };
    const length = b.len;
    std.debug.print("{d}\n", .{length});
}
