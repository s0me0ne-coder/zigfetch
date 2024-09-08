pub fn getDistroName() ![256]u8 {
    const std = @import("std");
    const str_eql = @import("string_eql.zig").string_eql;
    const file = try std.fs.openFileAbsolute("/etc/os-release", .{});
    var buffer: [256]u8 = [_]u8{0} ** 256;
    _ = try file.read(&buffer);
    var word_tmp: [256]u8 = [_]u8{0} ** 256;
    var key: [256]u8 = [_]u8{0} ** 256;
    var value: [256]u8 = [_]u8{0} ** 256;
    for (buffer, 0..buffer.len) |c, i| {
        switch (c) {
            '=' => {
                key = word_tmp;
                word_tmp = [_]u8{0} ** 256;
            },
            '\n' => {
                value = word_tmp;
                // i hate zig, this is my implementation of string comparison
                const dummy = "NAME";
                if (str_eql(&key, dummy)) {
                    return value;
                }
                word_tmp = [_]u8{0} ** 256;
                key = [_]u8{0} ** 256;
                value = [_]u8{0} ** 256;
            },
            else => {
                word_tmp[i] = c;
            },
        }
    }
    return [_]u8{0} ** 256;
}

test "getuname test" {
    const std = @import("std");
    const expect = @import("std").testing.expect;
    const suspect = try getDistroName();
    const suspect2 = "Gentoo";
    const str_eql = @import("string_eql.zig").string_eql;
    std.debug.print("{s}\n", .{suspect});
    std.debug.print("{s}\n", .{suspect2});
    try expect(str_eql(&suspect, suspect2));
}
