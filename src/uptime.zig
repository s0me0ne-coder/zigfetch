pub fn getUptime() ![256]u8 {
    const std = @import("std");
    const file = try std.fs.openFileAbsolute("/proc/uptime", .{});
    var buffer: [256]u8 = [_]u8{0} ** 256;
    var word_tmp: [256]u8 = [_]u8{0} ** 256;
    _ = try file.read(&buffer);
    for (buffer, 0..buffer.len) |c, i| {
        switch (c) {
            ' ' => {
                return word_tmp;
            },
            else => word_tmp[i] = c,
        }
    }
    return [_]u8{0} ** 256;
}
