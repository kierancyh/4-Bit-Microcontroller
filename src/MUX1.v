`timescale 1ns / 1ps

module MUX1 (
    input wire [3:0] MUX1_in1,          // 4-bit input from Register A
    input wire [3:0] MUX1_in2,          // 4-bit input from Register B
    input wire [15:0] control,          // Control signals
    output reg [7:0] MUX1_out           // 8-bit output (Zero-extended)
);

// Select and zero-extend inputs based on control signals
always @(*) begin
    if (control[3]) 
        MUX1_out = {4'b0000, MUX1_in1}; // Select and extend Register A
    else if (control[4]) 
        MUX1_out = {4'b0000, MUX1_in2}; // Select and extend Register B
    else if (control[7]) 
        MUX1_out = {4'b0000, MUX1_in1}; // Select A for ACC NZ A
    else
        MUX1_out = 8'b00000000;         // Default to zero
end

endmodule
