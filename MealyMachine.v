module MealyMachine(clk, in, reset, out);
input in, reset, clk;
output reg [3:0] out;
reg [3:0] state, next_state;
always@(*)begin
	case(state)
		4'd0 : next_state = (in) ? 4'd3 : 4'd1;
		4'd1 : next_state = (in) ? 4'd5 : 4'd2;
		4'd2 : next_state = (in) ? 4'd0 : 4'd3;
 		4'd3 : next_state = (in) ? 4'd1 : 4'd4;
		4'd4 : next_state = (in) ? 4'd2 : 4'd5;
		4'd5 : next_state = (in) ? 4'd4 : 4'd0;
		default : next_state = 4'd0;
	endcase
end
always@(posedge clk or negedge reset)begin
	if(!reset)begin
		state = 4'd0;
		out = 4'd0;
	end
	else begin
		state = next_state;
		out = state;
	end
end
endmodule
