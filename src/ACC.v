`timescale 1ns / 1ps

module ACC (
    input wire clk,                 // System clock
    input wire reset,               // Active-high reset signal
    input wire [7:0] ACC_in,        // Input from ALU
    input wire [15:0] control,      // Control signals
    output reg [7:0] ACC_out        // Stored result from ALU
);

// Update ACC on the falling edge of the clock or reset
always @(negedge clk or posedge reset) begin
    if (reset || control[15])       
        ACC_out <= 8'b00000000;     // Reset ACC to zero
    else 
        ACC_out <= ACC_in;          // Store ALU output
end

endmodule
