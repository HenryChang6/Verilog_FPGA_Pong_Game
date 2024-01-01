module fd_100Hz(
    input      clk,  // 50MHz input clk
    input      rst,
    output reg clk_100Hz
);

// 50,000,000Hz 到 100Hz需要的計數次數是500,000
// 由於每次計數兩個週期（上升和下降），所以實際計數250,000次
localparam COUNT_MAX = 250000;

reg [24:0] count;  // 25位計數器足以計數到25,000,000

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        clk_100Hz <= 0;
    end else begin
        if (count >= COUNT_MAX - 1) begin
            count <= 0;
            clk_100Hz <= ~clk_100Hz;  // 切換clk_1Hz信號
        end else begin
            count <= count + 1;
        end
    end
end

endmodule
