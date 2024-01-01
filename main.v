module main(
    input clk,
    input rst,
    // gen up & down via key_pad_controller.v
    input [3:0] kp_col,
    input start,
    output Hsync,
    output Vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output [7:0] dot_row1,
    output [7:0] dot_col1,
	 output [7:0] dot_row2,
    output [7:0] dot_col2,
    output [6:0] sd_sec_dig1, //七段顯示器 Hex0
    output [6:0] sd_sec_dig2, //七段顯示器 Hex1
    output [6:0] sd_min //七段顯示器 Hex2
);

// test

wire up1, up2, down1, down2;
wire clk_1Hz, clk_100Hz , clk_10kHz, clk_25MHz, clk_ball, clk_2s;
wire paddle1, paddle2;
wire ball_x, ball_y;
wire [3:0] min, sec1, sec2;
wire [11:0] h_cnt, v_cnt;
wire enable;
wire miss1, miss2;
reg[2:0] score1_q = 0, score1_d, score2_q = 0, score2_d;
// q 代表 現在值  d 代表 下一個時刻的值
reg [1:0] state_q, state_d;
wire stop;
reg newball_timer_start;


parameter [1:0] new_game = 0, play = 1, new_ball = 2, over = 3;

// 每個 clk 定期更新值
always @(posedge clk or negedge rst) 
begin
    if(!rst)
    begin
        state_q <= 2'd0;
        score1_q <= 0;
        score2_q <= 0;
    end
    else
    begin
        state_q <= state_d;
        score1_q <= score1_d;
        score2_q <= score1_d;
    end
end

assign stop = (state_q != play);

// FSM Game Logic
always @*
begin
	 if(!rst)
    begin
        state_d <= 2'd0;
    end
    else
		begin
		 case(state_q)

			  new_game:
			  begin
					score1_d = 0; score2_d = 0;
					if(start) state_d = play;
			  end

			  play:
			  begin
					if(min == 0 && sec1 == 0 && sec2 == 0)
						 state_d = over;
					
					else 
					begin
						 if(miss1 || miss2)
						 begin
							  newball_timer_start = 1;
							  if(miss1) score2_d = score2_q + 1;
							  else score1_d = score1_q + 1;
							  state_d = new_ball;
						 end
					end
			  end
			  
			  //when any of the player misses, 2 seconds will be alloted before the game can start again
			  new_ball:
			  begin   
					newball_timer_start = 0;
					if(clk_2s && start) state_d = play;
			  end

			  over:
			  begin 
					// When time over. End the game
					if(min == 0 && sec1 == 0 && sec2 == 0) 
						state_d = new_game;
			  end

			  default:
			  begin
					state_d = state_q;
					score1_d = score1_q;
					score2_d = score2_q;
			  end
		 endcase
	
	end

end

fd_1Hz fd1(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_1Hz(clk_1Hz)
);

fd_100Hz fd2(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_100Hz(clk_100Hz)
);

fd_10kHz fd3(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_10kHz(clk_10kHz)
);


fd_25MHz fd4(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_25MHz(clk_25MHz)
);



fd_ball fd5(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_25MHz(clk_ball)
);

two_sec_counter fd6(
    // input
    .clk(clk),
    .rst(rst),
    .start_counting(newball_timer_start),
    // output 
    .clk_2s(clk_2s)
);

key_pad_controller kp(
    // input
    .clk(clk_100Hz),
    .rst(rst),
    .kp_col(kp_col), 
    // output
    .up1(up1),
    .up2(up2),
    .down1(down1),
    .down2(down2),
);

state_machine sm (
    // input
    .clk(clk),
    .rst(rst),
    .stop(stop),
    .up1(up1),
    .up2(up2),
    .down1(down1),
    .down2(down2),
    .sec1(sec1), //每十秒增加速度
    // output
    .ball_x(ball_x),
    .ball_y(ball_y),
    .paddle1_q(paddle1),
    .paddle2_q(paddle2),
    .miss1(miss1),
    .miss2(miss2)
);

ascii_dot_matrix_controller dm1(
    // input
    .ascii_code(score1_q),
    .clk(clk_10kHz),
    // output
    .col(dot_col1),
    .row(dot_row1)
);

ascii_dot_matrix_controller dm2(
    // input
    .ascii_code(score2_q),
    .clk(clk_10kHz),
    // output
    .col(dot_col2),
    .row(dot_row2)
);


timer tt( //用一個 max_min parameter來倒數	
    // input
    .clk(clk_1Hz),
    .rst(rst),
    .start(start),
    // output
    .min(min),
    .sec1(sec1),
    .sec2(sec2)
);

seven_display_controller sd(
    // input
    .clk(clk),
    .rst(rst),
    .min(min),
    .sec1(sec1),
    .sec2(sec2),
    // output
    .sd_min(sd_min),
    .sd_sec_dig1(sd_sec_dig1),
    .sd_sec_dig2(sd_sec_dig2)
);

vga_controller vga(
    // input
    .clk(clk_25MHz),
    .rst(rst),
    // output
    .H_sync(Hsync),
    .V_sync(Vsync),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .enable(enable)
);

graphics_gen gp(
    // input
    .ball_x(ball_x),
    .ball_y(ball_y),
    .paddle_1(paddle1),
    .paddle_2(paddle2),
	.h_cnt(h_cnt),
	.v_cnt(v_cnt),
	.enable(enable),
    // output
    .red(red),
    .green(green),
    .blue(blue)
);


endmodule
