/// get username from given user id
pub fn getuname(uid: u32) ![256]u8 {
    const std = @import("std");
    const file = try std.fs.openFileAbsolute("/etc/passwd", .{});
    var buffer: [10000]u8 = [_]u8{0} ** 10000;
    _ = try file.read(&buffer);
    var uname = [_]u8{0} ** 256;
    var uname_backup = [_]u8{0} ** 256;
    var uid_backup = [_]u8{0} ** 256;
    var column: u32 = 0;
    var uname_idx: u32 = 0;
    for (buffer) |c| {
        switch (c) {
            // : means seperator
            ':' => {
                // we have a full uname variable lets back it up
                switch (column) {
                    0 => uname_backup = uname,
                    2 => uid_backup = uname,
                    else => {
                        // reset the volatile variable on each column
                        uname = [_]u8{0} ** 256;
                    },
                }
                // we better reset this
                uname_idx = 0;
                //
                column += 1;
            },
            // \n means reset state
            '\n' => {
                column = 0;
                uname_idx = 0;
                // we have a populated uname_backup and uid_backup
                // let's see if this is the user we want
                const uid_to_test: u32 = string_to_int(&uid_backup);
                if (uid == uid_to_test) {
                    // YAY WE FOUND IT
                    return uname_backup;
                } else {
                    // reset the backups
                    uname_backup = [_]u8{0} ** 256;
                    uid_backup = [_]u8{0} ** 256;
                    uname = [_]u8{0} ** 256;
                }
            },
            // other things mean store
            else => {
                uname[uname_idx] = c;
                uname_idx += 1;
            },
        }
    }
    return [_]u8{0} ** 256;
}

fn string_to_int(text: []const u8) u32 {
    var result: u32 = 0;
    for (text) |c| {
        if (c >= '0' and c <= '9') {
            result *= 10;
            result += c - '0';
        } else break;
    }
    return result;
}

test "parseint test" {
    const expect = @import("std").testing.expect;
    const suspect = string_to_int("10000");
    @import("std").debug.print("{d}\n", .{suspect});
    try expect(suspect == 10000);
}

test "getuid test" {
    const expect = @import("std").testing.expect;
    const u = try getuname(1000);
    @import("std").debug.print("{s}\n", .{u});
    try expect(u[0] == 'l' and u[1] == 'i' and u[2] == 'b' and u[3] == 'r' and u[4] == 'e' and u[5] == 'c' and u[6] == 'a' and u[7] == 't');
}
