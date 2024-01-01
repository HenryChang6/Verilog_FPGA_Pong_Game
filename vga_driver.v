module vga_driver
(
    input                   I_clk   , // 系统50MHz时钟
    input                   I_rst_n , // 系统复位
    output                  O_hs    , // VGA行同步信号
    output                  O_vs    , // VGA场同步信号
	 //input          [3:0]    I_red   , // VGA红色分量
    //input          [3:0]    I_green , // VGA绿色分量
    //input          [3:0]    I_blue  , // VGA蓝色分量
	 //output   reg   [3:0]    O_red   , // VGA红色分量
    //output   reg   [3:0]    O_green , // VGA绿色分量
    //output   reg   [3:0]    O_blue,   // VGA蓝色分量
	 output			 [11:0]   v_cnt,
	 output			 [11:0]	 h_cnt,
	 output 			 		    flag
);

// 分辨率为640*480时行时序各个参数定义
parameter       C_H_SYNC_PULSE      =   96  , 
                C_H_BACK_PORCH      =   48  ,
                C_H_ACTIVE_TIME     =   640 ,
                C_H_FRONT_PORCH     =   16  ,
                C_H_LINE_PERIOD     =   800 ;

// 分辨率为640*480时场时序各个参数定义               
parameter       C_V_SYNC_PULSE      =   2   , 
                C_V_BACK_PORCH      =   33  ,
                C_V_ACTIVE_TIME     =   480 ,
                C_V_FRONT_PORCH     =   10  ,
                C_V_FRAME_PERIOD    =   525 ;
                
parameter       C_COLOR_BAR_WIDTH   =   C_H_ACTIVE_TIME / 8  ;  

reg [11:0]      R_h_cnt         ; // 行时序计数器
reg [11:0]      R_v_cnt         ; // 列时序计数器
reg             R_clk_25M       ;

wire            W_active_flag   ; // 激活标志，当这个信号为1时RGB的数据可以显示在屏幕上

//////////////////////////////////////////////////////////////////
//功能： 产生25MHz的像素时钟
//////////////////////////////////////////////////////////////////
always @(posedge I_clk or negedge I_rst_n)
begin
    if(!I_rst_n)
        R_clk_25M   <=  1'b0        ;
    else
        R_clk_25M   <=  ~R_clk_25M  ;     
end
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
// 功能：产生行时序
//////////////////////////////////////////////////////////////////
always @(posedge R_clk_25M or negedge I_rst_n)
begin
    if(!I_rst_n)
        R_h_cnt <=  12'd0   ;
    else if(R_h_cnt == C_H_LINE_PERIOD - 1'b1)
        R_h_cnt <=  12'd0   ;
    else
        R_h_cnt <=  R_h_cnt + 1'b1  ;                
end                

assign O_hs =   (R_h_cnt < C_H_SYNC_PULSE) ? 1'b0 : 1'b1    ; 
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
// 功能：产生场时序
//////////////////////////////////////////////////////////////////
always @(posedge R_clk_25M or negedge I_rst_n)
begin
    if(!I_rst_n)
        R_v_cnt <=  12'd0   ;
    else if(R_v_cnt == C_V_FRAME_PERIOD - 1'b1)
        R_v_cnt <=  12'd0   ;
    else if(R_h_cnt == C_H_LINE_PERIOD - 1'b1)
        R_v_cnt <=  R_v_cnt + 1'b1  ;
    else
        R_v_cnt <=  R_v_cnt ;                        
end                

assign O_vs =   (R_v_cnt < C_V_SYNC_PULSE) ? 1'b0 : 1'b1    ; 
//////////////////////////////////////////////////////////////////  

assign W_active_flag =  (R_h_cnt >= (C_H_SYNC_PULSE + C_H_BACK_PORCH                  ))  &&
                        (R_h_cnt <= (C_H_SYNC_PULSE + C_H_BACK_PORCH + C_H_ACTIVE_TIME))  && 
                        (R_v_cnt >= (C_V_SYNC_PULSE + C_V_BACK_PORCH                  ))  &&
                        (R_v_cnt <= (C_V_SYNC_PULSE + C_V_BACK_PORCH + C_V_ACTIVE_TIME))  ;      

assign flag = W_active_flag;
assign v_cnt = R_v_cnt;
assign h_cnt = R_h_cnt;
//always @(posedge R_clk_25M or negedge I_rst_n)begin
//	if(!I_rst_n) 
//	begin
//		O_red   <=  4'b0000    ;
//		O_green <=  4'b0000    ;
//		O_blue  <=  4'b0000    ; 
//	end
//	else begin
//		if(W_active_flag) begin
//			O_red   <=    I_red    ;
//			O_green <=    I_green  ;
//			O_blue  <=    I_blue   ;
//		end
//		else begin
//			O_red    <=   4'b0000;
//			O_green  <=   4'b0000;
//			O_blue   <=   4'b0000;
//		end
//	end
//end
	

//////////////////////////////////////////////////////////////////
// 功能：把显示器屏幕分成8个纵列，每个纵列的宽度是80
//////////////////////////////////////////////////////////////////

endmodule
