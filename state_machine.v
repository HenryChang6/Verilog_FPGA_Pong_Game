/***********************************************************************************************************************
1. Idle/Start State: Waiting for the player to start the game.
2. Gameplay State: Where the actual game is played, controlling the movement of paddles and the ball.
3. Game Over State: When the game ends (could be due to a winning condition or a pause/stop command).
Note: 這個module不做score count
************************************************************************************************************************/

module state_machine(
    input  clk,
    input  rst,
    input  start,
    input  up1,
    input  up2,
    input  down1,
    input  down2,
    input  sec1,    //遊戲秒數的十位數 每增加一次遊戲速度就變快
    output ball_x,
    output ball_y,
    output paddle1, //paddle1的y座標（x座標不會動 不用管）
    output paddle2, //paddle2的y座標（x座標不會動 不用管）
 );

parameter [1:0] new_game = 2'd0;
parameter [1:0] play = 2'd1;
parameter [1:0] new_ball = 2'd2;
parameter [1:0] over = 2'd3;

// q 代表 現在值  d 代表 下一個時刻的值
reg [1:0] state_q, state_d;
reg ball_x_d, ball_y_d;

// 每個 clk 定期更新值
always @(posedge clk or negedge rst) 
begin
    if(!rst)
    begin
        state_q <= 2'd0;
        state_d <= 2'd0;
        ball_x <= 2'd0;
        ball_y <= 2'd0;
    end
    else
    begin
        state_q <= state_d;
        ball_x <= ball_x_d;
        ball_y <= ball_y_d;
    end
end





endmodule