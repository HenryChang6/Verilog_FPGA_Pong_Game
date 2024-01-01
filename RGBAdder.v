module RGBAdder(clk, reset, color, button);
input clk, reset, button;
reg [1:0] state, next_state;
reg [31:0] cnt;
output reg [3:0] color;
always@(*)begin
	case(state)
		2'b00 : next_state <= (button == 1'b0) ? 2'b01 : 2'b00; 
		2'b01 : next_state <= (button == 1'b0) ? 2'b10 : 1'b10;
		2'b10 : next_state <= (button == 1'b0) ? 2'b10 : 1'b00;
		default :next_state <= 2'b00; 
	endcase
end
always@(posedge clk or negedge reset)begin
	if(~reset)begin
		color <= 4'b0000;
		state <= 2'b00;
	end
	else begin
			case(state)
				2'b01 : color <= color + 1'd1;
				default : color <= color;
			endcase
			state <= next_state;
	end
end
endmodule
