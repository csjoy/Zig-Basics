const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;
const bufPrint = std.fmt.bufPrint;

test "position" {
    var b: [4]u8 = undefined;
    try expect(eql(u8, try bufPrint(&b, "{0s}{0s}{0s}{1s}", .{ "a", "b" }), "aaab"));
}

test "fill, alignment, width" {
    var b: [6]u8 = undefined;

    try expect(eql(
        u8,
        try bufPrint(&b, "{s: <5}", .{"hi!"}),
        "hi!  ",
    ));

    try expect(eql(
        u8,
        try bufPrint(&b, "{s:_^6}", .{"hi!"}),
        "_hi!__",
    ));

    try expect(eql(
        u8,
        try bufPrint(&b, "{s:!>6}", .{"hi!"}),
        "!!!hi!",
    ));
}

test "precision" {
    var b: [4]u8 = undefined;
    try expect(eql(
        u8,
        try bufPrint(&b, "{d:.2}", .{3.14159}),
        "3.14",
    ));
}
