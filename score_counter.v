module score_counter(
    input  ball_x,
    output score1,
    output score2,
);

always @(ball_x) begin
    state_q<=state_d;
    ball_q<=ball_d;
    score1_q<=score1_d;
    score2_q<=score2_d;
end

endmodule

