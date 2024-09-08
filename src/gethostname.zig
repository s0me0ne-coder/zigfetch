/// get username from given user id
pub fn gethostname() ![256]u8 {
    const std = @import("std");
    const file = try std.fs.openFileAbsolute("/etc/hostname", .{});
    var buffer: [256]u8 = [_]u8{0} ** 256;
    _ = try file.read(&buffer);
    return buffer;
}

test "getuname test" {
    const expect = @import("std").testing.expect;
    const suspect = try gethostname();
    const suspect2 = "laptop-dfadfasdf";
    for (suspect2, 0..suspect2.len) |c, i| {
        try expect(c == suspect[i]);
    }
}
