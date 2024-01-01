module Sync(clk, reset, Hsync, Vsync);
input clk, reset;
reg [31:0] ver_cnt;
reg [31:0] hor_cnt;
reg [31:0] cnt;
output reg Hsync, Vsync;
always@(posedge clk or negedge reset)begin
	if(~reset)begin
		Hsync <= 1'b0;
		Vsync <= 1'b0;
		ver_cnt <= 32'd0;
		hor_cnt <= 32'd0;
		cnt <= 32'd0;
	end
	else begin
		if(cnt == 210000)begin
			cnt <= 32'd0;
			Vsync = ~Vsync;
		end
		else begin
			cnt <= cnt + 1'd1;
		end

		if(hor_cnt == 799)begin
			hor_cnt <= 32'b0;
			if(ver_cnt == 524)begin
				ver_cnt <= 32'd0;
			end
			else begin
				ver_cnt<= ver_cnt + 1'd1;
			end
		end
		
		else begin
			hor_cnt <= hor_cnt + 1'd1;
		end
		
		if(ver_cnt <= 1)begin
			Hsync <= 1'b0;
		end
		
		else begin
			if(hor_cnt <= 95)begin
				Hsync <= 1'b0;
			end
			else begin
				Hsync <= 1'b1;
			end
		end
	end
end
endmodule
