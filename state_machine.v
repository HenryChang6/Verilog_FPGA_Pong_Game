/***********************************************************************************************************************
input兩個paddle上下移動之指令，output ball和兩個paddle的新位置
  -----
 | Info |
  -----
paddle 厚度 10 長度 50 的長方體
ball 邊長 10 的正方形
  -----
 | Note |
  -----
在 640x480 分辨率中，X 軸的範圍是 0 到 639。
在 640x480 分辨率中，Y 軸的範圍是 0 到 479。
************************************************************************************************************************/

module state_machine(
    input  clk,
    input  rst,
    input  start,
    input  up1,
    input  up2,
    input  down1,
    input  down2,
    input  sec1,    //遊戲秒數的十位數 （因為遊戲機制會是倒數結束，所以應該要是每減少一次，速度就上升一些）
    output ball_x,
    output ball_y,
    output paddle1, //paddle1的y座標（x座標不會動 不用管）
    output paddle2, //paddle2的y座標（x座標不會動 不用管）
    output miss1,   // player1 misses  
    output miss2,   // player2 misses
);

localparam  
            // X coordinate
            paddle1_L = 90,
            paddle1_R = 100,
            paddle2_L = 540,
            paddle2_R = 550,
            // size 
            paddle_length = 50,
            ball_side_length = 10,
            //velocity
            paddle_velovity = 8,
            ball_velocity = 4;




endmodule