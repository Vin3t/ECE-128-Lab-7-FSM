`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 03:17:15 PM
// Design Name: 
// Module Name: Mealy_tb
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


module Mealy_tb;
    reg P1, clk, rst;
    wire z;

    Mealy_Machine dut(.P1(P1),.clk(clk),.rst(rst),.z(z));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        P1 = 0;
        rst = 1;
        #10;
        rst = 0;

        #10 P1 = 1;
        #10 P1 = 0;
        #10 P1 = 1;
        #10 P1 = 0;
        
        P1 = 1; #10; // S1
        P1 = 0; #10; // S3
        P1 = 1; #10; // S3 + P1=1 -> z=1 again

        #50 $finish;
    end

endmodule
