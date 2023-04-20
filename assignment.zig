const std = @import("std");

pub fn main() void {
    const constant: i64 = 5;
    var variable: u64 = 5000;

    std.debug.print("{d} {d}\n", .{ constant, variable });
}
