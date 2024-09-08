const expect = @import("std").testing.expect;
const logo = @import("gentoo_logo.zig").logo;
const print = @import("std").debug.print;
pub fn getMaxWidth(comptime text: []const u8) usize {
    // get max chars until newline for each line and take the maximum value
    var line_length: usize = 0;
    var result: usize = 0;
    for (text) |s| {
        if (s == '\n') {
            if (line_length > result) result = line_length;
            line_length = 0;
        }
        line_length += 1;
    }

    return result;
}

test "sanity check" {
    const result: usize = getMaxWidth(logo);
    print("{}\n", .{result});
    // 12 good enough for now!
    //try expect(result == 11);
    try expect(result == 11);
}
