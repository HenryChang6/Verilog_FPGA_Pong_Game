module ascii_dot_matrix_controller (
    input clk,               // Clock input
    input [2:0] ascii_code,  // 7-bit ASCII code
    output reg [7:0] row,    // Row data for the dot matrix
    output reg [7:0] col     // Column data for the dot matrix
);

// ROM instance
wire [7:0] rom_data;
reg  [6:0] extended_ascii_code;
ascii_rom ascii_rom_instance (
    .clk(clk),
    .addr({extended_ascii_code, current_row}),
    .data(rom_data)
);

reg [3:0] current_row = 0;  // To cycle through the rows

// Update the display based on the ASCII code and current row
always @(posedge clk) begin
    extended_ascii_code <= {4'b0000, ascii_code} + 8'b00110000; 
    // Cycle through the rows of the dot matrix
    current_row <= current_row + 1;
    if (current_row == 7) current_row <= 0;
	 else
	 case(current_row) 
		3'd0: row <= 8'b01111111;
		3'd1: row <= 8'b10111111;
		3'd2: row <= 8'b11011111;
		3'd3: row <= 8'b11101111;
		3'd4: row <= 8'b11110111;
		3'd5: row <= 8'b11111011;
		3'd6: row <= 8'b11111101;
		3'd7: row <= 8'b11111110;
	 endcase

    // Set the row and column data based on the ROM output
    // row <= ~(1'b1 << current_row);  // Activate the current row
    col <= rom_data;             // Set the column pattern for the current row
end

endmodule
