const std = @import("std");
const gentoo_logo = @import("gentoo_logo.zig").logo;
const nixos_logo = @import("nixos_logo.zig").logo;
const getMaxWidth = @import("max_width.zig").getMaxWidth;
pub fn main() !void {
    //std.debug.print(nixos_logo, .{});
    //std.debug.print("\n", .{});
    // line1 : user and host name
    // line2 : distro from /etc/os-release
    // line3 : kernel version from /proc/version
    // line4 : uptime from /proc/uptime
    // line5 : package count from ?
    // line6 : free memory from /proc/meminfo
    const extra_spacing = 5;
    const max_line_width = getMaxWidth(gentoo_logo) + extra_spacing;
    var i: i32 = 0;
    for (gentoo_logo) |s| {
        if (s == '\n') {
            while (i < max_line_width - 1) : (i += 1) {
                std.debug.print(" ", .{});
            }

            std.debug.print("line: \n", .{});
            i = 0;
        } else {
            std.debug.print("{c}", .{s});
        }
        i += 1;
    }
    std.debug.print("\n", .{});
}
