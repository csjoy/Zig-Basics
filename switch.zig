const expect = @import("std").testing.expect;

// statement
test "switch statement" {
    var x: i8 = 100;
    switch (x) {
        -1...9 => {
            x = -x;
        },
        10, 100 => {
            x = @divExact(x, 10);
        },
        else => {
            x = 0;
        },
    }
    try expect(x == 10);
}

// expression
test "switch expression" {
    var x: i8 = 10;
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    try expect(x == 1);
}
