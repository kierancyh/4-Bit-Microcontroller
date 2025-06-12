`timescale 1ns / 1ps

module PC (
    input wire clk,
    input wire reset,
    input wire [1:0] Timing_Signal,         // Timing control
    output reg [4:0] PC_out                 // 5-bit PC (supports 32 instructions)
);

always @(posedge clk or posedge reset) begin
    if (reset)
        PC_out <= 5'b00000;                 // Reset PC to start at 0
    else if (Timing_Signal == 2'b11) begin  // Update at T3
        if (PC_out < 5'b11111)
            PC_out <= PC_out + 1;           // Increment PC normally
        else begin
            PC_out <= PC_out;               // Stop incrementing at 11111
        end
    end
end

endmodule
