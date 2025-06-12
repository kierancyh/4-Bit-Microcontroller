`timescale 1ns / 1ps

// Datapath Module 
/* This module represents the datapath of the system, connecting various components such as registers, multiplexers (MUX), 
the Arithmetic Logic Unit (ALU),  and the accumulator (ACC). It processes input control signals and data  
to compute and store results. */

module Datapath (
    input wire clk,                 // System Clock
    input wire reset,               // Reset Signal (Active High)
    input wire [15:0] control,      // Control Signal (16-bit Hot Encoded)
    input wire [3:0] Switch_A,      // External Input for Register A
    input wire [3:0] Switch_B,      // External Input for Register B

    // Outputs for Debugging and System Operations
    output wire [3:0] Reg_A,        // Register A Output
    output wire [3:0] Reg_B,        // Register B Output
    output wire [7:0] MUX1,         // MUX1 Output (Input Selection for ALU)
    output wire [7:0] Shifter,      // Shifter Output (Shifted Value)
    output wire Flag,               // Shifter Flag (LSB of Right Shift)
    output wire [7:0] MUX2,         // MUX2 Output (Selects between ALU Inputs)
    output wire [7:0] ALU,          // ALU Output (Arithmetic / Logic Computation)
    output wire [7:0] ACC,          // ACC Output (Stored Computation Result)
    output wire [7:0] Output_Reg    // Final Output Register
);

// Internal Wire Signals - These internal wires are used to pass data between components.

wire [3:0] RegA_out, RegB_out;      // Register A and B Outputs
wire [7:0] RegO_out;                // Output Register O  
wire [7:0] MUX1_out;                // Output of MUX1
wire [7:0] Shifter_out;             // Output of the Shifter
wire Shifter_Flag;                  // Shift Flag (Used for Condition Checks)
wire [7:0] MUX2_out;                // Output of MUX2
wire [7:0] ALU_out;                 // ALU Output
wire [7:0] ACC_out;                 // ACC Output

// Assign Debug Outputs - These assignments allow the outputs of the internal components to be externally observed for debugging or verification.

assign Reg_A = RegA_out;
assign Reg_B = RegB_out;
assign MUX1 = MUX1_out;
assign Shifter = Shifter_out;
assign Flag = Shifter_Flag;
assign MUX2 = MUX2_out;
assign ALU = ALU_out;
assign ACC = ACC_out;

// Register A Instantiation - Stores the value from Switch_A when control[0] is active.
Register #(.WIDTH(4)) RegA (
    .clk(clk),
    .reset(reset),
    .control(control[0]),       // Load when control[0] is set
    .Reg_in(Switch_A),          // Input from external switch
    .Reg_out(RegA_out)          // Output to MUX1
);

// Register B Instantiation - Stores the value from Switch_B when control[1] is active.
Register #(.WIDTH(4)) RegB (
    .clk(clk),
    .reset(reset),
    .control(control[1]),       // Load when control[1] is set
    .Reg_in(Switch_B),          // Input from external switch
    .Reg_out(RegB_out)          // Output to MUX1
);

// Register O Instantiation - Stores the final computed value from the ACC when control[2] is active.
Register #(.WIDTH(8)) RegO (
    .clk(clk),
    .reset(reset),
    .control(control[2]),       // Load when control[2] is set
    .Reg_in(ACC_out),           // Input from ACC
    .Reg_out(RegO_out)          // Output to Output_Reg
);

// MUX1 Instantiation - Selects between Register A and Register B as an input for the ALU.
MUX1 MUX1_unit (
    .MUX1_in1(RegA_out),        // Input from Register A
    .MUX1_in2(RegB_out),        // Input from Register B
    .control(control),          // Control signals determine selection
    .MUX1_out(MUX1_out)         // Selected output
);

// Shifter Instantiation - Performs left and right shifting operations based on control signals.
Shifter Shifter_unit (
    .clk(clk),
    .reset(reset),
    .Shifter_in(MUX1_out),      // Input from MUX1
    .control(control),          // Control signal for shift operations
    .Shifter_out(Shifter_out),  // Shifted output
    .flag(Shifter_Flag)         // Shift flag output
);

// MUX2 Instantiation - Selects between the MUX1 output and the Shifter output for ALU operations.
MUX2 MUX2_unit (
    .MUX2_in1(MUX1_out),        // Input from MUX1
    .MUX2_in2(Shifter_out),     // Input from Shifter
    .control(control),          // Control signals determine selection
    .MUX2_out(MUX2_out)         // Selected output
);

// ALU Instantiation - Performs arithmetic and logical operations based on control signals.
ALU ALU_unit (
    .clk(clk),
    .reset(reset),
    .ACC_out(ACC_out),          // Input from ACC (previous computation)
    .MUX2_out(MUX2_out),        // Input from MUX2
    .flag(Shifter_Flag),        // Flag for conditional operations
    .control(control),          // Control signals for ALU operations
    .ALU_out(ALU_out)           // Computed ALU result
);

// ACC Instantiation (Accumulator) - Stores the ALU output when control signals specify it.
ACC ACC_unit (
    .clk(clk),
    .reset(reset),
    .ACC_in(ALU_out),           // Takes ALU output as input
    .control(control),          // Control signals determine when to store ALU output
    .ACC_out(ACC_out)           // Stores computation result
);

// Assign Final Output - The output register holds the final computation result.
assign Output_Reg = RegO_out;   // Output Register O holds the final result

endmodule
