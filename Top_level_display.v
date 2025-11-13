`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 07:56:41 AM
// Design Name: 
// Module Name: Top_level_display
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


module Top_level_display(
    input wire mclk,             
    output wire [6:0] seg,       
    output wire [3:0] an    
    );

    wire clk_out;
    wire [11:0] bin_d_in;
    wire [15:0] bcd_d_out;
    wire rdy;
    wire done;
    reg [15:0] stat_bcd = 16'b0;
    wire en = 1'b1;      

    clk_divider divider_inst (.clk_in(mclk), .clk_out(clk_out));
    Up_counter_4096 counter_inst (.clk(clk_out), .rst(1'b0), .done(done), .bin_cnt(bin_d_in));
    BCD_Converter converter_inst (.clk(mclk), .en(en), .bin_d_in(bin_d_in), .bcd_d_out(bcd_d_out), .rdy(rdy));

    always @(posedge clk_out) begin
        if (rdy)
            stat_bcd <= bcd_d_out;
    end

    multi_seg_drive display_inst (.clk(mclk), .bcd_in(stat_bcd), .seg(seg), .an(an));
endmodule