`timescale 1ns / 1ps

module ALU (
    input wire clk,                 // System clock
    input wire reset,               // Active-high reset
    input wire flag,                // Flag for conditional operations
    input wire [7:0] ACC_out,       // Input from ACC
    input wire [7:0] MUX2_out,      // Input from MUX2
    input wire [15:0] control,      // Control signals
    output reg [7:0] ALU_out        // Computed ALU result
);

// ALU operations executed on rising clock edge or reset
always @(posedge clk or posedge reset) begin
    if (reset)
        ALU_out <= 8'b00000000;                                               // Reset ALU output
    else begin
        case (1'b1)  
            control[7]:  ALU_out <= flag ? (ACC_out + MUX2_out) : ALU_out;    // Add A if flag is set
            control[8]:  ALU_out <= flag ? (ACC_out + MUX2_out) : ALU_out;    // Add Shifter if flag is set
            control[9]:  ALU_out <= ACC_out + MUX2_out;                       // ADD
            control[10]: ALU_out <= ACC_out - MUX2_out;                       // SUB
            control[11]: ALU_out <= ~MUX2_out;                                // INV (Bitwise NOT)
            control[12]: ALU_out <= ACC_out & MUX2_out;                       // AND
            control[13]: ALU_out <= ACC_out | MUX2_out;                       // OR
            control[14]: ALU_out <= ACC_out ^ MUX2_out;                       // XOR
            default: ALU_out <= ALU_out;                                      // Retain previous value
        endcase
    end
end

endmodule
