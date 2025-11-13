`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lehigh University 
// Engineer: Vincent Langford
// 
// Create Date: 11/12/2025 10:10:58 PM
// Design Name: Up counter
// Module Name: Up_counter_4096
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


module Up_counter_4096(
    input wire clk,
    input wire rst,
    output reg done,
    output wire [11:0] bin_cnt
    );
    
    parameter c_reg_size = 34; 
    reg [c_reg_size - 1:0] count = 0;
    reg old_b = 0;
    
    always @(posedge clk) begin
        count <= count + 1;

        // Generate a done pulse whenever the bit used for clock division toggles
        if ((old_b && !count[c_reg_size - 12]) || (!old_b && count[c_reg_size - 12]))
            done <= 1;
        else
            done <= 0;

        old_b <= count[c_reg_size - 12];  // Remember previous divider bit state
    end

    // Extract 12 bits from the slower section of the counter
    assign bin_cnt = count[11:0];  // Lower 12 bits as output
endmodule
