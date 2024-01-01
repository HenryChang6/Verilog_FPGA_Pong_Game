module timer(
    input clk,
    input rst,
    input start,
    output reg [3:0] min,
    output reg [3:0] sec1, // 秒鐘的十位數
    output reg [3:0] sec2 // 秒鐘的個位數
);

initial 
begin
    min = 4'd2;
    sec1 = 4'd0;
    sec2 = 4'd0;
end

always @(posedge clk, negedge rst)
begin
    if(!rst)begin
        min <= 4'd2;
        sec1 <= 4'd0;
        sec2 <= 4'd0;
    end
    else begin
        if (start) begin
            // 如果秒鐘的個位數達到0且十位數也為0
            if (sec2 == 4'd0 && sec1 == 4'd0)begin
                if (min > 4'd0) begin
                    min <= min - 4'd1; // 減少一分鐘
                    sec1 <= 4'd5;
                    sec2 <= 4'd9;
                end
					 else begin
						min <= min;
						sec1 <= sec1;
						sec2 <= sec2;
					 end
            end
            else if (sec2 == 4'd0) 
            begin
            // 減少十秒
            sec1 <= sec1 - 4'd1;
            sec2 <= 4'd9;
            end
            else 
                begin
            // 減少一秒
                sec2 <= sec2 - 4'd1;
                end
        end
		  else
		  begin
				min <= min;
				sec1 <= sec1;
				sec2 <= sec2;
		  end
    end
end

endmodule

