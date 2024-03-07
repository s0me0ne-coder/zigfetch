fn getLineCount(input_str: []const u8) comptime_int {
    var result = 0;
    for (input_str) |s| {
        if (s == '\n') {
            result += 1;
        }
    }
    return result;
}

const std = @import("std");
const gentoo_logo = @import("gentoo_logo.zig").logo;
test "sanity_check_1" {
    try std.testing.expect(getLineCount(gentoo_logo) == 6);
}
