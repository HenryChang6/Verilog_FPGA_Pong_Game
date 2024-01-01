module seven_display_controller (
    input  rst,
	input  clk,
	input [3:0] min,
	input [3:0] sec1,
	input [3:0] sec2,
    output reg [6:0] sd_min,
    output reg [6:0] sd_sec_dig1,
	 output reg [6:0] sd_sec_dig2
);
    
    always @(min) 
	 begin
        case (min)
            4'h0: sd_min = 7'b1000000;
            4'h1: sd_min = 7'b1111001;
            4'h2: sd_min = 7'b0100100;
            4'h3: sd_min = 7'b0110000;
            4'h4: sd_min = 7'b0011001;
            4'h5: sd_min = 7'b0010010;
            4'h6: sd_min = 7'b0000010;
            4'h7: sd_min = 7'b1111000;
            4'h8: sd_min = 7'b0000000;
            4'h9: sd_min = 7'b0011000;
            4'hA: sd_min = 7'b0001000;
            4'hB: sd_min = 7'b0000011;
            4'hC: sd_min = 7'b1000110;
            4'hD: sd_min = 7'b0100001;
            4'hE: sd_min = 7'b0000110;
            4'hF: sd_min = 7'b0001110;
        endcase
    end
	 
	 always @(sec1) 
	 begin
        case (sec1)
            4'h0: sd_sec_dig1 = 7'b1000000;
            4'h1: sd_sec_dig1 = 7'b1111001;
            4'h2: sd_sec_dig1 = 7'b0100100;
            4'h3: sd_sec_dig1 = 7'b0110000;
            4'h4: sd_sec_dig1 = 7'b0011001;
            4'h5: sd_sec_dig1 = 7'b0010010;
            4'h6: sd_sec_dig1 = 7'b0000010;
            4'h7: sd_sec_dig1 = 7'b1111000;
            4'h8: sd_sec_dig1 = 7'b0000000;
            4'h9: sd_sec_dig1 = 7'b0011000;
            4'hA: sd_sec_dig1 = 7'b0001000;
            4'hB: sd_sec_dig1 = 7'b0000011;
            4'hC: sd_sec_dig1 = 7'b1000110;
            4'hD: sd_sec_dig1 = 7'b0100001;
            4'hE: sd_sec_dig1 = 7'b0000110;
            4'hF: sd_sec_dig1 = 7'b0001110;
        endcase
    end
	 
	 always @(sec2) 
	 begin
        case (sec2)
            4'h0: sd_sec_dig2 = 7'b1000000;
            4'h1: sd_sec_dig2 = 7'b1111001;
            4'h2: sd_sec_dig2 = 7'b0100100;
            4'h3: sd_sec_dig2 = 7'b0110000;
            4'h4: sd_sec_dig2 = 7'b0011001;
            4'h5: sd_sec_dig2 = 7'b0010010;
            4'h6: sd_sec_dig2 = 7'b0000010;
            4'h7: sd_sec_dig2 = 7'b1111000;
            4'h8: sd_sec_dig2 = 7'b0000000;
            4'h9: sd_sec_dig2 = 7'b0011000;
            4'hA: sd_sec_dig2 = 7'b0001000;
            4'hB: sd_sec_dig2 = 7'b0000011;
            4'hC: sd_sec_dig2 = 7'b1000110;
            4'hD: sd_sec_dig2 = 7'b0100001;
            4'hE: sd_sec_dig2 = 7'b0000110;
            4'hF: sd_sec_dig2 = 7'b0001110;
        endcase
    end

endmodule
