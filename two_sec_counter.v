module two_sec_counter(
    input clk,  //50MHz
    input rst,
    input start_counting,
    output reg clk_2s
);

reg[26:0] counter;  // 27位足以計數到 100,000,000

always @(posedge clk or negedge rst)
begin
    if (!rst) 
    begin
        counter <= 0;
        clk_2s <= 0;
    end 
    else if (start_counting)
    begin
        if (counter >= 100000000 - 1) 
        begin
            clk_2s <= 1;
            counter <= 0;  // 重置計數器
        end 
        else 
        begin
            clk_2s <= 0;
            counter <= counter + 1;
        end
    end
    else 
    begin
        // start_counting 為 0 
        clk_2s <= 0;
        counter <= 0;
    end
end

endmodule
