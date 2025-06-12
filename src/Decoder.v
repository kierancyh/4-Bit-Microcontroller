`timescale 1ns / 1ps

module Decoder (
    input wire [3:0] instruction,       // 4-bit instruction opcode
    input wire [1:0] Timing_Signal,     // Timing Signal (T0, T1, T2, T3)
    output reg [15:0] control           // 16-bit control signals
);

always @(*) begin
    control = 16'b0000000000000000;  // Default: No operation (NOP)

    if (Timing_Signal == 2'b10) begin   // Execute instruction at T2
        case (instruction)
            4'b0000: control = 16'b0000000000000001;    // LD A
            4'b0001: control = 16'b0000000000000010;    // LD B
            4'b0010: control = 16'b0000000000000100;    // LD O
            4'b0011: control = 16'b0000000000001000;    // LD SH A
            4'b0100: control = 16'b0000000000010000;    // LD SH B
            4'b0101: control = 16'b0000000000100000;    // SHR
            4'b0110: control = 16'b0000000001000000;    // SHL
            4'b0111: control = 16'b0000000010000000;    // ACC NZ A
            4'b1000: control = 16'b0000000100000000;    // ACC NZ SH
            4'b1001: control = 16'b0000001000000000;    // ADD
            4'b1010: control = 16'b0000010000000000;    // SUB
            4'b1011: control = 16'b0000100000000000;    // INV
            4'b1100: control = 16'b0001000000000000;    // AND
            4'b1101: control = 16'b0010000000000000;    // OR
            4'b1110: control = 16'b0100000000000000;    // XOR
            4'b1111: control = 16'b1000000000000000;    // CLR ACC
            default: control = 16'b0000000000000000;    // Default to NOP
        endcase
    end
end

endmodule
