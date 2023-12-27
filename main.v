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
wire clk_1Hz, clk_100Hz , clk_10kHz, clk_25MHz, clk_ball;
wire paddle1_x, paddle1_y, paddle2_x, paddle2_y;
wire ball_x, ball_y;
wire score1, score2;
wire [3:0] min, [3:0] sec1, [3:0] sec2;
wire enable;

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

ball_state_machine bsm (
    // input
    .clk(clk),
    .rst(rst),
    .start(start),
    // output
    .ball_x(ball_x),
    .ball_y(ball_y),
);

paddle_state_machine psm(
    // input
    .clk(clk),
    .rst(rst),
    .start(start),
    .up1(up1),
    .up2(up2),
    .down1(down1),
    .down2(down2),
    // output
    .paddle1_x(paddle1_x),
    .paddle1_y(paddle1_y),
    .paddle2_x(paddle2_x),
    .paddle2_y(paddle2_y),
);

score_counter sc(
    // input 
    .ball_x(ball_x),
    .ball_y(ball_y),
    // output
    .score1(score1),
    .score2(score2),
);

dot_matrix_controller dm(
    // input
    .score1(score1),
    .score2(score2),
    .clk(clk_10kHz),
    .rst(rst),
    // output
    .dot_col(dot_col),
    .dot_row(dot_row),
);

timer tt(
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
    .enable(enable),
);

graphics_gen gp(
    // input
    .enable(enable),
    .ball_x(ball_x),
    .ball_y(ball_y),
    .paddle1_x(paddle1_x),
    .paddle1_y(paddle1_y),
    .paddle2_x(paddle2_x),
    .paddle2_y(paddle2_y),
    // output
    .red(red),
    .green(green),
    .blue(blue),
);


endmodule
