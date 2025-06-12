`timescale 1ns / 1ps

module ROM (
    input wire [4:0] address,               // 5-bit address from PC
    output reg [3:0] instruction            // 4-bit instruction output
);

always @(*) begin
    case (address)
        5'b00000: instruction = 4'b0000;    // LD A
        5'b00001: instruction = 4'b0001;    // LD B
        5'b00010: instruction = 4'b0100;    // LD SH B
        5'b00011: instruction = 4'b0101;    // SHR
        5'b00100: instruction = 4'b0111;    // ACC NZ A
        5'b00101: instruction = 4'b0101;    // SHR
        5'b00110: instruction = 4'b0011;    // LD SH A
        5'b00111: instruction = 4'b0110;    // SHL
        5'b01000: instruction = 4'b1000;    // ACC NZ SH
        5'b01001: instruction = 4'b0100;    // LD SH B
        5'b01010: instruction = 4'b0101;    // SHR
        5'b01011: instruction = 4'b0101;    // SHR
        5'b01100: instruction = 4'b0101;    // SHR
        5'b01101: instruction = 4'b0011;    // LD SH A
        5'b01110: instruction = 4'b0110;    // SHL
        5'b01111: instruction = 4'b0110;    // SHL
        5'b10000: instruction = 4'b1000;    // ACC NZ SH
        5'b10001: instruction = 4'b0100;    // LD SH B
        5'b10010: instruction = 4'b0101;    // SHR
        5'b10011: instruction = 4'b0101;    // SHR
        5'b10100: instruction = 4'b0101;    // SHR
        5'b10101: instruction = 4'b0101;    // SHR
        5'b10110: instruction = 4'b0011;    // LD SH A
        5'b10111: instruction = 4'b0110;    // SHL
        5'b11000: instruction = 4'b0110;    // SHL
        5'b11001: instruction = 4'b0110;    // SHL
        5'b11010: instruction = 4'b1000;    // ACC NZ SH
        5'b11011: instruction = 4'b0010;    // LD O
        5'b11100: instruction = 4'b1111;    // CLR ACC
        5'b11101: instruction = 4'b1111;    // CLR ACC
        5'b11110: instruction = 4'b1111;    // CLR ACC
        5'b11111: instruction = 4'b1111;    // CLR ACC
        default: instruction = 4'b0000;     // Default NOP
    endcase
end

endmodule
