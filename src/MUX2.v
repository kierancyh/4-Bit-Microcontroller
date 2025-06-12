`timescale 1ns / 1ps

module MUX2 (
    input wire [7:0] MUX2_in1,          // 8-bit input from MUX1
    input wire [7:0] MUX2_in2,          // 8-bit input from Shifter
    input wire [15:0] control,          // Control signals
    output reg [7:0] MUX2_out           // Selected output
);

// Select input based on control signals
always @(*) begin
    if (control[7]) 
        MUX2_out = MUX2_in1;            // Select MUX1 output (ACC NZ A)
    else if (control[8]) 
        MUX2_out = MUX2_in2;            // Select Shifter output (ACC NZ SH)
    else 
        MUX2_out = MUX2_out;            // Retain previous value
end

endmodule
