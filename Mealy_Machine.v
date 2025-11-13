`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lehigh University
// Engineer: Vincent Langford
// 
// Create Date: 10/30/2025 02:07:19 PM
// Design Name: Mealy Machine 
// Module Name: Mealy_Machine
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


module Mealy_Machine(
    input P1,clk,rst,
    output reg z
    );
    
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b110;
    reg [2:0] PS, NS;
    
    always @(posedge clk) begin 
        if (rst)
            PS <= S0;
        else
            PS <= NS;
    end 

    always @(*) begin 
        case (PS)
            S0: NS = (P1) ? S1 : S0;
            S1: NS = (P1) ? S2 : S0;
            S2: NS = (P1) ? S2 : S3;
            S3: NS = (P1) ? S1 : S0;
        endcase
    end 
    
    always @(*) begin
        z = 0; // default
        if (PS == S3 && P1 == 1)
            z = 1; // sequence 1101 detected
    end
endmodule
