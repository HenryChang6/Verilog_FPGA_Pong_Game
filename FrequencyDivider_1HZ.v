module FrequencyDivider_1HZ(
    input clk,        // 50MHz clock input
    input reset,      // Asynchronous reset
    output reg clk_div // 1Hz clock output
);
    // Assuming a 50MHz input clock, we need a 25e6-1 counter to create a 1Hz clock
    reg [24:0] count; // 25-bit counter to store intermediate values

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 0;
            clk_div <= 0;
        end else begin
            if (count == 25000000 - 1) begin
                count <= 0;
                clk_div <= ~clk_div; // Toggle the output clock
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule