`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 09:01:58 AM
// Design Name: 
// Module Name: multi_seg_drive
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


module multi_seg_drive(
    input wire clk,
    input wire [15:0] bcd_in,
    output reg [6:0] seg,
    output reg [3:0] an
);
    reg [1:0] digit_select = 0;
    reg [3:0] current_digit;
    reg [15:0] refresh_counter = 0;

 
    function [6:0] bcd_to_seg;
        input [3:0] num;
        begin
            case (num)
                4'd0: bcd_to_seg = 7'b1000000;
                4'd1: bcd_to_seg = 7'b1111001;
                4'd2: bcd_to_seg = 7'b0100100;
                4'd3: bcd_to_seg = 7'b0110000;
                4'd4: bcd_to_seg = 7'b0011001;
                4'd5: bcd_to_seg = 7'b0010010;
                4'd6: bcd_to_seg = 7'b0000010;
                4'd7: bcd_to_seg = 7'b1111000;
                4'd8: bcd_to_seg = 7'b0000000;
                4'd9: bcd_to_seg = 7'b0010000;
                default: bcd_to_seg = 7'b1111111;
            endcase
        end
    endfunction

    // Refresh rate control (~1 kHz digit switch)
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        if (refresh_counter == 50000) begin
            refresh_counter <= 0;
            digit_select <= digit_select + 1;
        end
    end

    // Select active digit and corresponding BCD nibble
    always @(*) begin
        case (digit_select)
            2'd0: begin an = 4'b1110; current_digit = bcd_in[3:0];   end
            2'd1: begin an = 4'b1101; current_digit = bcd_in[7:4];   end
            2'd2: begin an = 4'b1011; current_digit = bcd_in[11:8];  end
            2'd3: begin an = 4'b0111; current_digit = bcd_in[15:12]; end
        endcase
        seg = bcd_to_seg(current_digit);
    end
endmodule