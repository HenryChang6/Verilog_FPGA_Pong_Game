module graphics_gen(
    input [11:0] paddle_1,
	 input [11:0] paddle_2,
	 input [11:0] ball_x,
    input [11:0] ball_y,
    input [11:0] v_cnt,
    input [11:0] h_cnt,
    input enable,
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
);


parameter h_sync_pulse = 96,
          h_back_porch = 48,
          h_period = 640;

parameter v_sync_pulse = 2,
          v_back_porch = 33,
          v_period = 480;


parameter border_thickness = 10;

parameter paddle_length = 50,
          paddle_thickness = 10;

parameter ball_side = 10;

wire border;
wire serving_line;
wire paddle;
wire ball;

assign border = (h_cnt < (h_sync_pulse + h_back_porch + border_thickness)) ||
				(h_cnt > (h_sync_pulse + h_back_porch + h_period - border_thickness - 1)) ||
				(v_cnt < (v_sync_pulse + v_back_porch + border_thickness)) ||
				(v_cnt > (v_sync_pulse + v_back_porch + v_period - border_thickness - 1));
					 
assign serving_line = (h_cnt > (h_sync_pulse + h_back_porch + h_period/2 - border_thickness/2)) && 
					  (h_cnt < (h_sync_pulse + h_back_porch + h_period/2 + border_thickness/2));

assign paddle = ((h_cnt > (h_sync_pulse + h_back_porch + border_thickness*4)) &&
                (h_cnt < (h_sync_pulse + h_back_porch + border_thickness*4 + paddle_thickness)) &&
                (v_cnt > (v_sync_pulse + v_back_porch + paddle_1)) &&
                (v_cnt < (v_sync_pulse + v_back_porch + paddle_1 + paddle_length))) ||
                ((h_cnt > (h_sync_pulse + h_back_porch + h_period - 1'd1 - border_thickness*4 - paddle_thickness)) &&
                (h_cnt < (h_sync_pulse + h_back_porch + h_period - 1'd1 - border_thickness*4)) &&
                (v_cnt > (v_sync_pulse + v_back_porch + paddle_2)) &&
                (v_cnt < (v_sync_pulse + v_back_porch + paddle_2 + paddle_length)));
					 
assign ball = (h_cnt > (h_sync_pulse + h_back_porch + ball_x)) &&
              (h_cnt < (h_sync_pulse + h_back_porch + ball_x + ball_side)) &&
              (v_cnt > (v_sync_pulse + v_back_porch + ball_y)) &&
              (v_cnt < (v_sync_pulse + v_back_porch + ball_y + ball_side));
		
always@(*)begin
	if(enable) begin
		if(border || serving_line || paddle || ball) begin
			red = 4'd15;
			green = 4'd15;
			blue = 4'd15;
		end
		else begin
			red = 4'd0;
			green = 4'd0;
			blue = 4'd0;
		end
	end
	else begin
		red = 4'd0;
		green = 4'd0;
		blue = 4'd0;
	end
end

endmodule