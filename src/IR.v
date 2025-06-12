`timescale 1ns / 1ps

module IR (
    input wire clk,
    input wire reset,
    input wire [1:0] Timing_Signal,         // Timing control
    input wire [3:0] IR_in,                 // Instruction from ROM
    output reg [3:0] IR_out                 // Stored instruction output
);

always @(posedge clk or posedge reset) begin
    if (reset)
        IR_out <= 4'b0000;                  // Reset instruction
    else if (Timing_Signal == 2'b00)        // Fetch at T0
        IR_out <= IR_in;
end

endmodule
