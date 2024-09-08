pub fn string_eql(a: []const u8, b: []const u8) bool {
    if (a.len > b.len) {
        for (b, 0..b.len) |c, i| {
            if (c != a[i]) return false;
        }
    } else {
        for (a, 0..a.len) |c, i| {
            if (c != b[i]) return false;
        }
    }
    return true;
}

test "string_eql test" {
    const str1 = "hello";
    const str2 = "hello";
    try @import("std").testing.expect(string_eql(str1, str2));
}
