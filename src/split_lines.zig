const expect = @import("std").testing.expect;
fn calculate_lines(text: []const u8) u32 {
    var i: u32 = 0;
    for (text) |s| {
        switch (s) {
            '\n' => i += 1,
            else => {},
        }
    }
    return i;
}

test "calculate lines test" {
    const logo =
        \\ _-----_
        \\(       \
        \\\    0   \
        \\ \        )
        \\ /      _/
        \\(     _-
        \\\____-
    ;
    try expect(calculate_lines(logo) == 6);
}

fn split_lines(text: []const u8,line_count: u32) [][]const u8 {
    var end_result: [][]const u8 = undefined;
    var line_length:u32 = 0; 
    var line_index:u32 = 0;
    for(text) |c| {
        switch(s) {
            '\n' => {

            },
            else => {

            }
        }
    }
}
