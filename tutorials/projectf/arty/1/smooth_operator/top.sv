`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2021 19:51:08
// Design Name: 
// Module Name: top
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

module top (
    input wire logic [3:0] sw,
    input wire logic [3:0] btn,
    output     logic [3:0] led
    );

    always_comb begin
        if (sw[0] == 0 && sw[1] == 1) begin
            led[3:0] = btn[0] ? 4'b1001 : 4'b0110;
        end else begin
            led[3:0] = 4'b0000;
        end
    end
endmodule
