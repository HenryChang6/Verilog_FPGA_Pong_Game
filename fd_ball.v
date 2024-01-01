module fd_ball(
    input      clk,  // 50MHz input clk
    input      rst,
    output reg clk_25MHz // 25MHz
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        clk_25MHz <= 0;
    end else begin
        clk_25MHz <= ~clk_25MHz;  // 在每個輸入時鐘的上升沿翻轉輸出時鐘的狀態
    end
end

endmodule
