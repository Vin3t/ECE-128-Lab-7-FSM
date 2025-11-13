`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 07:38:28 PM
// Design Name: 
// Module Name: Moore_Machine_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Moore_Machine_tb;
    reg clk, rst, P1;
    wire z;
    
    Moore_Machine dut(.clk(clk),.rst(rst),.P1(P1),.z(z));
    
    // Clock generation: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Initialize inputs
    rst = 1;
    P1  = 0;
    
    // Hold reset for a few cycles
    #12;
    rst = 0;

    // Apply the sequence 1-1-0-1
    #10 P1 = 1;
    #10 P1 = 1;
    #10 P1 = 0;
    #10 P1 = 1;

    // Add a few more random bits
    #10 P1 = 0;
    #10 P1 = 1;
    #10 P1 = 0;
    #20 
    $finish;
    end
endmodule
