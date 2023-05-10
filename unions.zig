const expect = @import("std").testing.expect;

// Unions = Only one value of many possible types fields be active at a time

const Result = union { int: i64, float: f64, bool: bool };

test "simple union" {
    var result = Result{ .int = 1234 };
    _ = result;
    // result.float = 12.34; // this will results in panic
}

const Tag = enum { a, b, c };
const Tagged = union(Tag) { a: u8, b: f32, c: bool };

test "switch on tagged union" {
    var value = Tagged{ .b = 1.5 };
    switch (value) {
        .a => |*byte| byte.* += 1,
        .b => |*float| float.* *= 2,
        .c => |*b| b.* = !b.*,
    }
    try expect(value.b == 3);
}

const Tagged1 = union(enum) { a: u8, b: f32, c: bool };
const Tagged2 = union(enum) { a: u8, b: f32, c: bool, none }; // here node is of type void
