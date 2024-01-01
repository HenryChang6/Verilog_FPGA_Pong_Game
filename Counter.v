module Counter(in, clk, reset, count);
input clk, reset;
input [1:0] in;
output reg [3:0] count;
always@(posedge clk or negedge reset) begin
	if(!reset)begin
		count <= 4'd10;
	end
	else begin
		if(count == 4'd0)begin
			case(in)
				2'b00 : count <= 4'd3;
				2'b01 : count <= 4'd15;
				2'b10 : count <= 4'd10;
				default count <= 4'd15;
			endcase
		end
		else begin
			count <= count - 4'd1;
		end
	end
end
endmodule
