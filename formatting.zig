const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;

test "fmt" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const allocator = gpa.allocator();

    const string = try std.fmt.allocPrint(allocator, "{d} + {d} = {d}", .{ 9, 10, 19 });
    defer allocator.free(string);

    try expect(eql(u8, string, "9 + 10 = 19"));
}

test "print" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const allocator = gpa.allocator();

    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    try list.writer().print("{} + {} = {}", .{ 9, 10, 19 });
    try expect(eql(u8, list.items, "9 + 10 = 19"));
}

test "hello world" {
    const out_file = std.io.getStdOut();
    try out_file.writer().print("Hello, {s}!\n", .{"World"});
}

test "array printing" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const allocator = gpa.allocator();
    const string = try std.fmt.allocPrint(
        allocator,
        "{any} + {any} = {any}",
        .{
            @as([]const u8, &[_]u8{ 1, 4 }),
            @as([]const u8, &[_]u8{ 2, 5 }),
            @as([]const u8, &[_]u8{ 3, 9 }),
        },
    );
    defer allocator.free(string);

    try expect(eql(u8, string, "{ 1, 4 } + { 2, 5 } = { 3, 9 }"));
}

const Person = struct {
    name: []const u8,
    birthYear: i32,
    deathYear: ?i32,

    pub fn format(self: Person, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;

        try writer.print("{s} ({}-", .{ self.name, self.birthYear });
        if (self.deathYear) |year| {
            try writer.print("{}", .{year});
        }

        try writer.writeAll(")");
    }
};

test "custom fmt" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const allocator = gpa.allocator();

    const john = Person{
        .name = "John Carmack",
        .birthYear = 1970,
        .deathYear = null,
    };

    const johnString = try std.fmt.allocPrint(allocator, "{s}", .{john});
    defer allocator.free(johnString);

    try expect(eql(u8, johnString, "John Carmack (1970-)"));

    const claude = Person{
        .name = "Claude Shannon",
        .birthYear = 1916,
        .deathYear = 2001,
    };

    const claudeString = try std.fmt.allocPrint(allocator, "{s}", .{claude});
    defer allocator.free(claudeString);

    try expect(eql(u8, claudeString, "Claude Shannon (1916-2001)"));
}
