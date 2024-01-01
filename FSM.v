module FSM(clk, reset, count, out);
input clk, reset;
output [3:0] count;
output [1:0] out;
reg [1:0] state, next_state;
wire clock_div, clk_div;
assign out = state;
FrequencyDivider_1HZ u_FreqDiv_1HZ (.clk(clk), .reset(reset), .clk_div(clock_div));
Counter(.in(out), .clk(clock_div), .reset(reset), .count(count));
always@(*)begin
	case(state)
		2'b00 : next_state <= (count == 0) ? 2'b01: state;
		2'b01 : next_state <= (count == 0) ? 2'b10: state;
		2'b10 : next_state <= (count == 0) ? 2'b00: state;
		default : next_state <= 2'b00;
	endcase
end
always@(posedge clock_div or negedge reset)begin
	if(!reset)begin
		state <= 2'b00;
	end
	else begin
		state <= next_state;
	end
end
endmodule
