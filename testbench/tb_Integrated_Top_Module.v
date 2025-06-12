`timescale 1ns / 1ps

module tb_Integrated_Top_Module;

// Testbench Signals
reg clk;
reg reset;
reg [3:0] Switch_A;                 // Input for Register A
reg [3:0] Switch_B;                 // Input for Register B
wire [3:0] Reg_A, Reg_B;            // Output from Register A and B
wire [7:0] MUX1, Shifter, MUX2;
wire [7:0] ALU, ACC, Output_Reg; 
wire Flag;                          // Shifter Flag
wire [4:0] PC_out;                  // Program Counter Output
wire [3:0] IR_out;                  // Instruction Register Output
wire [15:0] control;                // 16-bit Control Signal

// Instantiate the Integrated Top Module
Integrated_Top_Module DUT (
    .clk(clk),
    .reset(reset),
    .Switch_A(Switch_A),
    .Switch_B(Switch_B),
    .Reg_A(Reg_A),
    .Reg_B(Reg_B),
    .MUX1(MUX1),
    .Shifter(Shifter),
    .Flag(Flag),
    .MUX2(MUX2),
    .ALU(ALU),
    .ACC(ACC),
    .Output_Reg(Output_Reg),
    .PC_out(PC_out),
    .IR_out(IR_out),
    .control(control)
);

// Clock Generation: 10ns Period (100MHz)
always #5 clk = ~clk;

// Test Sequence
initial begin
    // Initialize Signals
    clk = 0;
    reset = 1;
    Switch_A = 4'b0000;
    Switch_B = 4'b0000;
    
    #10 reset = 0;  // Release reset

    // Load Inputs (15 x 15 Multiplication)
    #20 Switch_A = 4'b1010;  // Load Register A with 10 
    #20 Switch_B = 4'b1010;  // Load Register B with 10 

    // Print Header
    $display(" Time  |  PC   | Instruction | Control Signal       | ACC | Output_Reg");
    $display("---------------------------------------------------------------");

    // Monitor Outputs
    forever begin  
        #10;
        $display("%0t | %05b | %04b        | %016b | %08b | %08b", 
                 $time, PC_out, IR_out, control, ACC, Output_Reg);
        
        // Stop Simulation when PC reaches last instruction (11111)
        if (PC_out == 5'b11111) begin
            $display("Simulation complete: PC reached 11111.");
            $display("Expected Result: %d x %d = %d ", Switch_A, Switch_B, (Switch_A * Switch_B) & 8'hFF);         
            $display("Output Register Value: %d", Output_Reg);
            $finish;
        end
    end
end

endmodule

