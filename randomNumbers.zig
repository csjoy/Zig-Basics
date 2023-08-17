const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

test "random numbers" {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });

    const rand = prng.random();
    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    print("a: {}, b: {}, c: {}, d: {}\n", .{ a, b, c, d });
}

test "crypto random numbers" {
    const rand = std.crypto.random;
    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    print("a: {}, b: {}, c: {}, d: {}\n", .{ a, b, c, d });
}
