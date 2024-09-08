pub fn main() void {
    const string1 = "hello";
    const string2 = "world";
    const slice1 = string1[0..string1.len];
    const slice2 = string2[0..string1.len];
    if (slice1 == slice2) {
        @import("std").debug.print("The strings are the same", .{});
    }
}
pub fn somestring() []const u8 {
    return "hello world";
}

test "random test" {
    const string1 = "hello";
    @import("std").testing.expect(string1 == somestring());
}
