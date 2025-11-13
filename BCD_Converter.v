`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lehigh University
// Engineer: Vincent Langford
// 
// Create Date: 11/13/2025 07:19:48 AM
// Design Name: BCD converter 12 --> 16 bits
// Module Name: BCD_Converter
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


module BCD_Converter(
    input clk, en,              // Start conversion enable
    input [11:0] bin_d_in, 
    output [15:0] bcd_d_out,
    output rdy              
);

    parameter IDLE  = 3'b000;
    parameter SETUP = 3'b001;
    parameter ADD   = 3'b010;
    parameter SHIFT = 3'b011;
    parameter DONE  = 3'b100;

    reg [2:0] state = IDLE;
    reg [27:0] bcd_data = 0;
    reg [3:0] sh_counter = 0;
    reg [1:0] add_counter = 0;
    reg result_rdy = 0;
    reg busy = 0;

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                result_rdy <= 0;
                busy <= 0;
                if (en)
                    state <= SETUP;
            end

            SETUP: begin
                busy <= 1;
                bcd_data <= {16'd0, bin_d_in}; // initialize
                sh_counter <= 0;
                state <= ADD;
            end

            ADD: begin
                // Add 3 to any BCD nibble > 4
                if (bcd_data[27:24] > 4) bcd_data[27:24] <= bcd_data[27:24] + 3;
                if (bcd_data[23:20] > 4) bcd_data[23:20] <= bcd_data[23:20] + 3;
                if (bcd_data[19:16] > 4) bcd_data[19:16] <= bcd_data[19:16] + 3;
                state <= SHIFT;
            end

            SHIFT: begin
                bcd_data <= bcd_data << 1;
                sh_counter <= sh_counter + 1;
                if (sh_counter == 11)
                    state <= DONE;
                else
                    state <= ADD;
            end

            DONE: begin
                result_rdy <= 1;
                busy <= 0;
                state <= IDLE;
            end

            default: state <= IDLE;
        endcase
    end

    assign bcd_d_out = bcd_data[27:12];  // take the upper 16 bits as BCD result
    assign rdy = result_rdy;
endmodule
