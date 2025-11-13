`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 09:00:37 AM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input clk_in,
    output reg clk_out =0
);
    parameter DIV = 26000000;  // Adjust for ~2Hz blinking speed
    reg [25:0] count = 0;

    always @(posedge clk_in) begin
        count <= count + 1;
        if (count == DIV) begin
            clk_out <= ~clk_out;
            count <= 0;
        end
    end
endmodule
