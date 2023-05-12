const expect = @import("std").testing.expect;

const Window = opaque {
    fn show(self: *Window) void {
        show_window(self);
    }
};
const Button = opaque {};

extern fn show_window(*Window) callconv(.C) void;

test "opaque" {
    var main_window: *Window = undefined;
    _ = main_window;
    // show_window(main_window);

    var ok_button: *Button = undefined;
    _ = ok_button;
    // show_window(ok_button);
}

test "opaque with declarations" {
    var main_window: *Window = undefined;
    main_window.show();
}
