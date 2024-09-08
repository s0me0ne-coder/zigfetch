const std = @import("std");
const gentoo_logo = @import("gentoo_logo.zig").logo;
const nixos_logo = @import("nixos_logo.zig").logo;
const getMaxWidth = @import("max_width.zig").getMaxWidth;
const getHostName = @import("gethostname.zig").gethostname;
const getUserName = @import("getuname.zig").getuname;
const getDistro = @import("distro_name.zig").getDistroName;
const getKernelVersion = @import("linux_kernel_version.zig").getLinuxKernelVersion;
const getUptime = @import("uptime.zig").getUptime;
const extra_spacing = 5;
const max_line_width = getMaxWidth(gentoo_logo) + extra_spacing;
pub fn main() !void {
    //std.debug.print(nixos_logo, .{});
    //std.debug.print("\n", .{});
    // line1 : user and host name
    const hostname = try getHostName();
    const username = try getUserName(1000);
    // line2 : distro from /etc/os-release
    const distro = try getDistro();
    // line3 : kernel version from /proc/version
    const kernelversion = try getKernelVersion();
    // line4 : uptime from /proc/uptime
    const uptime = try getUptime();
    // line5 : package count from ?
    // line6 : free memory from /proc/meminfo

    // printing
    var line: usize = 0;
    var spaces: usize = 0;
    for (gentoo_logo) |s| {
        switch (s) {
            '\n' => {
                for (0..(max_line_width - spaces)) |_| {
                    std.debug.print(" ", .{});
                }
                switch (line) {
                    0 => {
                        // /etc/hostname terminates with \n
                        std.debug.print("{s}@{s}", .{ username, hostname });
                    },
                    1 => {
                        std.debug.print("Distro: {s}\n", .{distro});
                    },
                    2 => {
                        std.debug.print("Kernel: {s}\n", .{kernelversion});
                    },
                    3 => {
                        std.debug.print("Uptime: {s}\n", .{uptime});
                    },
                    else => {
                        std.debug.print("TODO", .{});
                        std.debug.print("\n", .{});
                    },
                }
                line += 1;
                spaces = 0;
            },
            else => {
                std.debug.print("{c}", .{s});
                spaces += 1;
            },
        }
    }
    // final line of info

    // final newline after the program is done
    std.debug.print("\n", .{});
}
