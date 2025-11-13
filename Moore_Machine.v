`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lehigh University
// Engineer: Vincent Langford
// 
// Create Date: 10/30/2025 01:40:35 PM
// Design Name: Moore Machine FSM
// Module Name: Moore_Machine
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


module Moore_Machine(
    input P1,clk,rst,
    output reg z
    );
    
    //States 
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] PS, NS;
    
    //State Register
    always @(posedge clk) begin 
        if (rst)
            PS <= S0;
        else
            PS <= NS;
    end 
       
    //NS
    always @(*) begin 
        case (PS)
            S0: NS = (P1) ? S1 : S0;
            S1: NS = (P1) ? S2 : S0;
            S2: NS = (P1) ? S2 : S3;
            S3: NS = (P1) ? S2 : S4;
            //Goes back after seq is detected
            S4: NS = (P1) ? S1 : S0;
        endcase
    end 
    
        always @(*) begin
            case (PS)
                S4: z = 1'b1;   
            endcase
    end
endmodule
