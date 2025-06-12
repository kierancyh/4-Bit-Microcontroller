`timescale 1ns / 1ps

module Shifter (
    input wire clk,                     // System clock
    input wire reset,                   // Active-high reset
    input wire [7:0] Shifter_in,        // 8-bit input from MUX1
    input wire [15:0] control,          // Control signals
    output reg [7:0] Shifter_out,       // 8-bit shifted output
    output reg flag                     // Flag for right shift LSB
);

// Shift operations executed on rising clock or reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        Shifter_out <= 8'b00000000;         // Reset shifter
        flag <= 1'b0;                       // Reset flag
    end
    else if (control[3] || control[4])  
        Shifter_out <= Shifter_in;          // Load Shifter with Register A or B
    else if (control[5]) begin        
        flag <= Shifter_out[0];             // Capture LSB before shift
        Shifter_out <= Shifter_out >> 1;    // Shift Right (SHR)
    end 
    else if (control[6])              
        Shifter_out <= Shifter_out << 1;    // Shift Left (SHL)
end

endmodule
