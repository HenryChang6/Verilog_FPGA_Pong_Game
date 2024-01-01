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
ROM --> Read Only Memory
q --> current status  d --> next second status
************************************************************************************************************************/

module state_machine(
    input  clk,
    input  rst,
    input  stop,
    input  up1,
    input  up2,
    input  down1,
    input  down2,
    input  sec1,    //遊戲秒數的十位數 （因為遊戲機制會是倒數結束，所以應該要是每減少一次，速度就上升一些）
    output [9:0] ball_x,
    output [9:0] ball_y,
    output [9:0] paddle1_q, //paddle1的y座標（x座標不會動 不用管）
    output [9:0] paddle2_q, //paddle2的y座標（x座標不會動 不用管）
    output reg miss1,   // player1 misses  
    output reg miss2   // player2 misses
);


parameter  // X coordinate
            paddle1_L = 39,
            paddle1_R = 49,
            paddle2_L = 590,
            paddle2_R = 600,
            // size 
            paddle_length = 50,
            ball_side_length = 10,
            //velocity
            PADDLE_VELOCITY = 8,
            BALL_VELOCITY_POS = 2,  // down, rihgt
            BALL_VELOCITY_NEG = -2, // up, left
            // Border (wall thick = 10)
            X_RIGHT_BOUNDARY = 630, 
            X_LEFT_BOUNDARY = 9,
            Y_BTM_BOUNDARY = 470,
            Y_TOP_BOUNDARY = 9;
        
reg [9:0] paddle1_top_q = 214, paddle1_top_d; 
reg [9:0] paddle2_top_q = 214, paddle2_top_d; 
reg [9:0] ball_x_q = 319, ball_y_q = 280, ball_x_d, ball_y_d;
reg ball_xdelta_q = 0, ball_xdelta_d; // 1 --> bounce from left
reg ball_ydelta_q = 0, ball_ydelta_d; // 0 --> bounce from right

// 定期更新 register 值
always @(posedge clk, negedge rst)
begin
  if(!rst)
  begin
    paddle1_top_q <= 214;
    paddle2_top_q <= 214;
    ball_x_q <= 280;
    ball_y_q <= 280;
    ball_xdelta_q <= 0;
    ball_ydelta_q <= 0;
  end
  else
  begin
    paddle1_top_q <= paddle1_top_d;
    paddle2_top_q <= paddle2_top_d;
    ball_x_q<=ball_x_d;
    ball_y_q<=ball_y_d;
    ball_xdelta_q<=ball_xdelta_d;
    ball_ydelta_q<=ball_ydelta_d;
  end
end

// ball movement & miss judger
always @(*) 
begin
  paddle1_top_d = paddle1_top_q;
  paddle2_top_d = paddle2_top_q;
  ball_x_d = ball_x_q;
  ball_y_d = ball_y_q;
  ball_xdelta_d = ball_xdelta_q;
  ball_ydelta_d = ball_ydelta_q;
  miss1 = 0;
  miss2 = 0;
  if(stop)
  begin
    ball_x_d = 319; //ball @ center of screen
    ball_y_d = 239; //ball @ center of screen
    ball_xdelta_d = 0;
    ball_ydelta_d = 1;
    paddle1_top_d = 214; //bar @ center
    paddle2_top_d = 214; //bar @ center
  end
  else 
  begin
		
    // paddle 1 
    if (up1 && paddle1_top_q > Y_TOP_BOUNDARY + PADDLE_VELOCITY)
      paddle1_top_d = paddle1_top_q - PADDLE_VELOCITY;

    else if (down1 && paddle1_top_q < (Y_BTM_BOUNDARY - PADDLE_VELOCITY))
      paddle1_top_d = paddle1_top_q + PADDLE_VELOCITY;
	 else 
		paddle1_top_d = paddle1_top_d;

    // paddle 2
    if (up2 && paddle2_top_q > Y_TOP_BOUNDARY + PADDLE_VELOCITY)
      paddle2_top_d = paddle2_top_q - PADDLE_VELOCITY;

    else if (down2 && paddle2_top_q < (Y_BTM_BOUNDARY - PADDLE_VELOCITY))
      paddle2_top_d = paddle2_top_q + PADDLE_VELOCITY;
	 else 
		paddle2_top_d = paddle2_top_d;

    // bounce from paddle1 (left)
    if( ball_x_q <= paddle1_R && 
        paddle1_L <= ball_x_q && 
        paddle1_top_q <= (ball_y_q + ball_side_length) && 
        ball_y_q <= (paddle1_top_q + paddle_length)) 

        ball_xdelta_d = 1;  
			

    // bounce from paddle2 (right)
		else if( (paddle2_L <= (ball_x_q + ball_side_length) &&
             ((ball_x_q + ball_side_length) <= paddle2_R) &&
             paddle2_top_q <= (ball_y_q + ball_side_length)) && 
             ball_y_q <= (paddle2_top_q + paddle_length) )

          ball_xdelta_d = 0; 
	   else
		    ball_xdelta_d = ball_xdelta_d;

    // bounce from top
		if(ball_y_q <= Y_TOP_BOUNDARY) 
      ball_ydelta_d = 1; 

    // bounce from bottom
		else if(Y_BTM_BOUNDARY <= (ball_y_q + ball_side_length)) 
      ball_ydelta_d = 0; 
	   
		else
		   ball_ydelta_d = ball_ydelta_d;

    // player miss Determination
    if(ball_x_d > X_RIGHT_BOUNDARY) 
        miss2 = 1;
	 else if(X_LEFT_BOUNDARY > ball_x_d)
		  miss1 = 1;
	 else
	     begin
		  miss1 = miss1;
		  miss2 = miss2;
		  end
    
    // 更新 ball position
    ball_x_d = ball_xdelta_d ? (ball_x_q + BALL_VELOCITY_POS) : (ball_x_q + BALL_VELOCITY_NEG);
    ball_y_d = ball_ydelta_d ? (ball_y_q + BALL_VELOCITY_POS) : (ball_y_q + BALL_VELOCITY_NEG);

    
  end
end

// velocity adjust
// ...
// ...
// ...

// 輸出賦值
assign paddle1_q = paddle1_top_d;
assign paddle2_q = paddle2_top_d;
assign ball_x = ball_x_q;
assign ball_y = ball_y_q;


endmodule
