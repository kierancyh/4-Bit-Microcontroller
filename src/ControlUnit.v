`timescale 1ns / 1ps

module ControlUnit (
    input wire clk,
    input wire reset,
    output wire [15:0] control,   // 16-bit control signal to Datapath
    output wire [4:0] PC_out,     // Expose PC output to testbench
    output wire [3:0] IR_out      // Expose IR output to testbench
);

wire [1:0] Timing_Signal;         // Timing Signal (T0, T1, T2, T3)
wire [3:0] instruction;           // Instruction fetched from ROM

// Instantiate Ring Counter (Generates Timing_Signal)
RingCounter RC (
    .clk(clk),
    .reset(reset),
    .Timing_Signal(Timing_Signal)
);

// Instantiate Program Counter (Generates Address for ROM)
PC PC_unit (
    .clk(clk),
    .reset(reset),
    .Timing_Signal(Timing_Signal),
    .PC_out(PC_out)               // Outputs program counter address
);

// Instantiate Program Memory (ROM)
ROM ROM_unit (
    .address(PC_out),
    .instruction(instruction)     // Fetches instruction from ROM
);

// Instantiate Instruction Register (IR)
IR IR_unit (
    .clk(clk),
    .reset(reset),
    .Timing_Signal(Timing_Signal),
    .IR_in(instruction),          // Stores instruction from ROM at T0
    .IR_out(IR_out)               // Outputs stored instruction
);

// Instantiate Instruction Decoder
Decoder Decoder_unit (
    .instruction(IR_out),        // Uses IR output to generate control signals
    .Timing_Signal(Timing_Signal),
    .control(control)
);

endmodule
