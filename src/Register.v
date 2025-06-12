`timescale 1ns / 1ps

module Register #(
    parameter WIDTH = 4             // Default width is 4-bit, can be changed
)(
    input wire clk,                 // Clock signal
    input wire reset,               // Reset signal (Active High)
    input wire [15:0] control,      // Control signal (16-bit Hot Encoded)
    input wire [WIDTH-1:0] Reg_in,  // Data input (width can be 4 or 8 bits)
    output reg [WIDTH-1:0] Reg_out  // Data output (width can be 4 or 8 bits)
);

always @(posedge clk or posedge reset) begin
    if (reset)
        Reg_out <= {WIDTH{1'b0}};   // Reset register to 0
    else if (control)               // Load values only when control is high
        Reg_out <= Reg_in;          
end

endmodule
