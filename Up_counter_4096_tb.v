`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lehigh University
// Engineer: Vincent Langford
// 
// Create Date: 11/12/2025 10:11:38 PM
// Design Name: Up counter testbench
// Module Name: Up_counter_4096_tb
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


module Up_counter_4096_tb;
    reg clk;
    wire done;
    wire [11:0] bin_cnt;


    Up_counter_4096 uut (.clk(clk),.done(done),.bin_cnt(bin_cnt));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        #1000000; 
        $finish;
    end
endmodule
