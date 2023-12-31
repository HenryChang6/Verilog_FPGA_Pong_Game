module fd_1Hz(
    input      clk,  // 50MHz input clk
    input      rst,
    output reg clk_1Hz
);

// 50MHz到1Hz需要的計數次數是50,000,000
// 由於每次計數兩個週期（上升和下降），所以實際計數25,000,000次
localparam COUNT_MAX = 25000000;

reg [24:0] count;  // 25位計數器足以計數到25,000,000

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        clk_1Hz <= 0;
    end else begin
        if (count >= COUNT_MAX - 1) begin
            count <= 0;
            clk_1Hz <= ~clk_1Hz;  // 切換clk_1Hz信號
        end else begin
            count <= count + 1;
        end
    end
end

endmodule
