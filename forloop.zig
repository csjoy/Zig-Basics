const std = @import("std");

test "for" {
    const string = [_]u8{ 'a', 'b', 'c' };
    std.debug.print("\n", .{});

    for (string, 0..) |character, index| {
        std.debug.print("index: {d} value: {d}\n", .{ index, character });
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}
