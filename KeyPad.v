module KeyPad(clk, reset, keypadCol, keypadRow, dot_col, dot_row);
input clk, reset;
input [3:0] keypadCol;
output reg [3:0] keypadRow;
output reg [7:0] dot_col, dot_row;
reg [31:0] keypadDelay;
reg [2:0] row_count;
always@(posedge clk or negedge reset)begin
	if(!reset)begin
		keypadRow <= 4'b0111;
		keypadDelay <= 32'b0;
		row_count <= 3'b000;
		dot_row <= 8'b0;
		dot_col <= 8'b0;
	end
	else begin
		row_count <= row_count+1;
		case(row_count)
			3'd0 : dot_row <= 8'b01111111;
			3'd1 : dot_row <= 8'b10111111;
			3'd2 : dot_row <= 8'b11011111;
			3'd3 : dot_row <= 8'b11101111;
			3'd4 : dot_row <= 8'b11110111;
			3'd5 : dot_row <= 8'b11111011;
			3'd6 : dot_row <= 8'b11111101;
			3'd7 : dot_row <= 8'b11111110;
		endcase
		case({keypadRow, keypadCol})
				8'b0111_0111 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b11000000;
					3'd1 : dot_col <= 8'b11000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b0111_1011 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00110000;
					3'd1 : dot_col <= 8'b00110000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b0111_1101 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00001100;
					3'd1 : dot_col <= 8'b00001100;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b0111_1110 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000011;
					3'd1 : dot_col <= 8'b00000011;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1011_0111 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b11000000;
					3'd3 : dot_col <= 8'b11000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1011_1011 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00110000;
					3'd3 : dot_col <= 8'b00110000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1011_1101 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00001100;
					3'd3 : dot_col <= 8'b00001100;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1011_1110 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000011;
					3'd3 : dot_col <= 8'b00000011;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1101_0111 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b11000000;
					3'd5 : dot_col <= 8'b11000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1101_1011 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00110000;
					3'd5 : dot_col <= 8'b00110000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1101_1101 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00001100;
					3'd5 : dot_col <= 8'b00001100;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1101_1110 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000011;
					3'd5 : dot_col <= 8'b00000011;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
				8'b1110_0111 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b11000000;
					3'd7 : dot_col <= 8'b11000000;
				endcase
				end
				8'b1110_1011 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00110000;
					3'd7 : dot_col <= 8'b00110000;
				endcase
				end
				8'b1110_1101 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00001100;
					3'd7 : dot_col <= 8'b00001100;
				endcase
				end
				8'b1110_1110 : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000011;
					3'd7 : dot_col <= 8'b00000011;
				endcase
				end
				default : begin
					case(row_count)
					3'd0 : dot_col <= 8'b00000000;
					3'd1 : dot_col <= 8'b00000000;
					3'd2 : dot_col <= 8'b00000000;
					3'd3 : dot_col <= 8'b00000000;
					3'd4 : dot_col <= 8'b00000000;
					3'd5 : dot_col <= 8'b00000000;
					3'd6 : dot_col <= 8'b00000000;
					3'd7 : dot_col <= 8'b00000000;
				endcase
				end
		endcase
		if(keypadDelay == 100 -1)begin
			keypadDelay <= 32'b0;
			case(keypadRow)
				4'b0111 : keypadRow <= 4'b1011;
				4'b1011 : keypadRow <= 4'b1101;
				4'b1101 : keypadRow <= 4'b1110;
				4'b1110 : keypadRow <= 4'b0111;
				default : keypadRow <= 4'b0111;
			endcase
		end
		else begin
			keypadDelay <= keypadDelay+1'b1;
		end
	end
end
endmodule
