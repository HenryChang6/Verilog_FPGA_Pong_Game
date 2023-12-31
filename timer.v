module timer(
    input clk,
    input rst,
    input start,
    output reg [3:0] min,
    output reg [3:0] sec1, // 秒鐘的十位數
    output reg [3:0] sec2, // 秒鐘的個位數
);

always @(posedge clk, negedge rst)
begin
    if(!rst)
    begin
        min <= 4'd2;
        sec1 <= 0;
        sec <= 0;
    end
    else
    begin
        
    end
end

endmodule

