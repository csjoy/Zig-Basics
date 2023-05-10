const expect = @import("std").testing.expect;

fn increment(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

test "naughty pointer" {
    var x: u16 = 0;
    _ = x;
    // Trying to set a *T to the value 0 is detectable illegal behaviour
    // var y: *u8 = @intToPtr(*u8, x);
    // _ = y;
}

test "const pointers" {
    const x: u8 = 1;
    var y = &x;
    _ = y;
    // y.* += 1;
}

test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}
