`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lehigh University
// Engineer: Vincent Langford
// 
// Create Date: 11/13/2025 07:38:41 AM
// Design Name: BCD converter testbench
// Module Name: BCD_Converter_tb
// Project Name: FSM
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


module BCD_Converter_tb;
    reg clk;
    reg en;
    reg [11:0] bin_d_in;
    wire [15:0] bcd_d_out;
    wire rdy;
    
     BCD_Converter dut(.clk(clk),.en(en),.bin_d_in(bin_d_in),.bcd_d_out(bcd_d_out),.rdy(rdy));
        
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        en = 0;
        bin_d_in = 0;

        // Wait for some time before starting
        #20;

        // Test 1: 0
        bin_d_in = 12'd0;
        en = 1;
        #10 
        en = 0;
        wait (rdy);
        #20;

        // Test 2: 255
        bin_d_in = 12'd255;
        en = 1;
        #10 en = 0;
        wait (rdy);
        #20;

        // Test 3: 999
        bin_d_in = 12'd999;
        en = 1;
        #10 en = 0;
        wait (rdy);
        #20;

        // Test 4: 12'd4095 
        bin_d_in = 12'd4095;
        en = 1;
        #10 en = 0;
        wait (rdy);
        #20;
        $finish;
    end
endmodule
