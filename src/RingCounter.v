`timescale 1ns / 1ps

module RingCounter (
    input wire clk,
    input wire reset,
    output reg [1:0] Timing_Signal              // 2-bit signal for timing (T0, T1, T2, T3)
);

always @(posedge clk or posedge reset) begin
    if (reset)
        Timing_Signal <= 2'b00;                 // Start at T0 on reset
    else 
        Timing_Signal <= Timing_Signal + 1;     // Cycle through T0 → T1 → T2 → T3
end

endmodule
