`timescale 1ns / 1ps

module Integrated_Top_Module(
    input wire clk,                     // System clock
    input wire reset,                   // Active-high reset signal
    input wire [3:0] Switch_A,          // External input for Register A
    input wire [3:0] Switch_B,          // External input for Register B

    // Outputs for Debugging and FPGA Display
    output wire [3:0] Reg_A,            // Register A Output
    output wire [3:0] Reg_B,            // Register B Output
    output wire [7:0] MUX1,             // MUX1 Output
    output wire [7:0] Shifter,          // Shifter Output
    output wire Flag,                   // Shifter Flag (LSB of Right Shift)
    output wire [7:0] MUX2,             // MUX2 Output
    output wire [7:0] ALU,              // ALU Output
    output wire [7:0] ACC,              // ACC Output
    output wire [7:0] Output_Reg,       // Final Output Register
    output wire [4:0] PC_out,           // Program Counter Output
    output wire [3:0] IR_out,           // Instruction Register Output
    output wire [15:0] control          // 16-bit Control Signal
);

// Internal Wire to Connect Modules
assign control = control_signal;    // Ensure output control is correctly assigned    
wire [15:0] control_signal;             // Control Unit's control output

// Instantiate Control Unit
ControlUnit CU (
    .clk(clk),
    .reset(reset),
    .control(control_signal),       // 16-bit control signal to Datapath
    .PC_out(PC_out),                // Program Counter Output
    .IR_out(IR_out)                 // Instruction Register Output
);

// Instantiate Data Path
Datapath DP (
    .clk(clk),
    .reset(reset),
    .control(control_signal),       // Receives control signal from Control Unit
    .Switch_A(Switch_A),            // Switch A input to Register A
    .Switch_B(Switch_B),            // Switch B input to Register B

    // Expose Outputs for Debugging
    .Reg_A(Reg_A),
    .Reg_B(Reg_B),
    .MUX1(MUX1),
    .Shifter(Shifter),
    .Flag(Flag),
    .MUX2(MUX2),
    .ALU(ALU),
    .ACC(ACC),
    .Output_Reg(Output_Reg)
);

endmodule
