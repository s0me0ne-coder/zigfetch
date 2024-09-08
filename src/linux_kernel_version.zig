pub fn getLinuxKernelVersion() ![256]u8 {
    const std = @import("std");
    const file = try std.fs.openFileAbsolute("/proc/version", .{});
    var buffer: [256]u8 = [_]u8{0} ** 256;
    var word_tmp: [256]u8 = [_]u8{0} ** 256;
    _ = try file.read(&buffer);
    var spaces: u8 = 0;
    for (buffer, 0..buffer.len) |c, i| {
        switch (c) {
            ' ' => {
                if (spaces == 2) {
                    return word_tmp;
                }
                word_tmp = [_]u8{0} ** 256;
                spaces += 1;
            },
            else => word_tmp[i] = c,
        }
    }
    return [_]u8{0} ** 256;
}

test "getuname test" {
    const std = @import("std");
    const expect = @import("std").testing.expect;
    const suspect = try getLinuxKernelVersion();
    const suspect2 = "6.10.3-gentoo-dist";
    const str_eql = @import("string_eql.zig").string_eql;
    std.debug.print("{s}\n", .{suspect});
    std.debug.print("{s}\n", .{suspect2});
    try expect(str_eql(&suspect, suspect2));
}
