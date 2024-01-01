module fd_25MHz(
				input clk,
				input rst,
				output reg clk_25MHz
);	
always@(posedge clk or negedge rst)begin
	if(!rst)
		clk_25MHz <= 1'd0;
	else
		clk_25MHz <= ~clk_25MHz;
end
endmodule
