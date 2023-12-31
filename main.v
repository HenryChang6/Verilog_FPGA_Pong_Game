module main(
    input clk,
    input rst,
    // gen up & down via key_pad_controller.v
    input [3:0] kp_row,
    input [3:0] kp_col,
    input start,
    output Hsync,
    output Vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output [7:0] dot_row,
    output [7:0] dot_col,
    output [6:0] sd_sec_dig1, //七段顯示器 Hex0
    output [6:0] sd_sec_dig2, //七段顯示器 Hex1
    output [6:0] sd_min, //七段顯示器 Hex2
);

// up1    A 
// down1  0
// up2    8
// down2  7
wire up1, up2, down1, down2;
wire clk_1Hz, clk_100Hz , clk_10kHz, clk_25MHz, clk_ball, clk_2s;
wire paddle1, paddle2;
wire ball_x, ball_y;
wire [3:0] min, [3:0] sec1, [3:0] sec2;
wire [11:0] h_cnt, [11:0] v_cnt;
wire enable;
wire miss1, miss2;
reg[2:0] score1_q = 0, score1_d, score2_q = 0, score2_d;
// q 代表 現在值  d 代表 下一個時刻的值
reg [1:0] state_q, state_d;
reg stop;
reg newball_timer_start;


parameter [1:0] new_game = 0, play = 1, new_ball = 2, over = 3;

// 每個 clk 定期更新值
always @(posedge clk or negedge rst) 
begin
    if(!rst)
    begin
        state_q <= 2'd0;
        state_d <= 2'd0;
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


// FSM 
always @(*)
begin
    // 確保若沒有改變 下一個狀況有值
    state_d = state_q;
    score1_d = score1_q;
	score2_d = score2_q;
    stop = 1;
    newball_timer_start = 0;
    case(state_q)

        new_game:
        begin
            score1_d = 0; score2_d = 0;
            min = 0; sec1 = 0; sec2 = 0;
            if(start) state_d = play;
        end

        play:
        begin
            stop = 0;
            if(min = 0 && sec1 = 0 && && sec2 = 0)
            begin
                stop = 1;
                start = 0;
                state_d = over;
            end
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
            if(clk_2s && start) state_d = play;
        end

        over:
        begin 
            // When time over. End the game
            if(min = 0 && sec1 = 0 && && sec2 = 0) state_d = new_game;
        end

        default:
            state_d = new_game;
    endcase

end

fd_1Hz fd1(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_1Hz(clk_1Hz),
);

fd_100Hz fd2(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_100Hz(clk_100Hz),
);

fd_10kHz fd3(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_10kHz(clk_10kHz),
);

fd_25MHz fd4(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_25MHz(clk_25MHz),
);

fd_ball fd5(
    // input
    .clk(clk),
    .rst(rst),
    // output
    .clk_25MHz(clk_ball),
);

two_sec_counter fd6(
    // input
    .clk(clk),
    .rst(rst),
    .start_counting(newball_timer),
    // output 
    .clk_2s(clk_2s),
);


key_pad_controller kp(
    // input
    .clk(clk_100Hz),
    .rst(rst),
    .kp_row(kp_row),
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
    .start(start),
    .up1(up1),
    .up2(up2),
    .down1(down1),
    .down2(down2),
    .sec1(sec1), //每十秒增加速度
    // output
    .ball_x(ball_x),
    .ball_y(ball_y),
    .paddle1(paddle1),
    .paddle2(paddle2),
    .miss1(miss1),
    .miss2(miss2),
);

dot_matrix_controller dm(
    // input
    .score1(score1_q),
    .score2(score2_q),
    .clk(clk_10kHz),
    .rst(rst),
    // output
    .dot_col(dot_col),
    .dot_row(dot_row),
);

timer tt( //用一個 max_min parameter來倒數
    // input
    .clk(clk_1Hz),
    .rst(rst),
    .start(start),
    // output
    .min(min),
    .sec1(sec1),
    .sec2(sec2),
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
    .sd_sec_dig2(sd_sec_dig2),
);

vga_controller vga(
    // input
    .clk(clk_25MHz),
    .rst(rst),
    // output
    .Hsync(Hsync),
    .Vsync(Vsync),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .enable(enable),
);

graphics_gen gp(
    // input
    .enable(enable),
    .ball_x(ball_x),
    .ball_y(ball_y),
    .paddle1(paddle1),
    .paddle2(paddle2),
    // output
    .red(red),
    .green(green),
    .blue(blue),
);


endmodule
