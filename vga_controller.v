module (
	input clk,
	input rst,
	input H_sync,
	input V_sync,
	output reg [11:0] h_cnt,
	output reg [11:0] v_cnt,
	output enable,
);
parameter H_sync_pulse = 96,
		  H_back_porch = 48,
		  H_active_time = 640,
		  H_front_porch = 16,
		  H_line_period = 800;
 
parameter V_sync_pusle = 2,
		  V_back_porch = 33,
		  V_active_time = 480,
		  V_front_porch = 10,
		  V_frame_period = 525;

always@(posedge clk or negedge rst)begin
	if(!rst)
		h_cnt <= 12'd0;
	else if(h_cnt == H_line_period - 1'b1)
		h_cnt <= 12'd0;
	else
		h_cnt <= h_cnt + 1'b1;
end

always@(posedge clk or negedge rst)begin
	if(!rst)
		v_cnt <= 12'd0;
	else if(v_cnt == V_frame_period - 1'b1)
		v_cnt <= 12'd0;
	else if(h_cnt == H_line_period - 1'b1)
		v_cnt <= v_cnt + 1'b1;
	else
		v_cnt <= v_cnt;
end

assign enable = (h_cnt >= (H_sync_pulse + H_back_porch))&&
                (h_cnt <= (H_sync_pulse + H_back_porch + H_active_time))&& 
                (v_cnt >= (V_sync_pulse + V_back_porch))&&
                (v_cnt <= (V_sync_pulse + V_back_porch + V_active_time)); 

endmodule
