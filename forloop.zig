const std = @import("std");
const expect = std.testing.expect;

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

test "inline for" {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0;
    inline for (types) |T| sum += @sizeOf(T);
    try expect(sum == 10);
}
