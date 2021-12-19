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
    input  wire logic clk,
    input  wire logic [3:0] sw,
    output      logic [3:0] led_r,
    output      logic [3:0] led_g,
    output      logic [3:0] led_b
    );
    
    localparam DIV_BY = 24'd10_000_000;  // 10 million
    
    logic [7:0] led_r0_duty, led_g0_duty, led_b0_duty;
    logic [5:0] brightness;
    
    pwm pwm_led_r0 (.clk, .duty(led_r0_duty), .pwm_out(led_r[0]));
    pwm pwm_led_g0 (.clk, .duty(led_g0_duty), .pwm_out(led_g[0]));
    pwm pwm_led_b0 (.clk, .duty(led_b0_duty), .pwm_out(led_b[0]));

    logic stb;
    logic direction = 0;
    logic [1:0] decColour = 0;
    logic [23:0] cnt = 0;
    always_ff @(posedge clk) begin
        if (cnt != DIV_BY-1) begin
            stb <= 0;
            cnt <= cnt + 1;
        end else begin
            stb <= 1;
            cnt <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if (brightness == 63 && direction == 1) direction <= 0;
        if (brightness == 1 && direction == 0) direction <= 1;
    
        if (stb && direction == 1) brightness <= brightness + 1;
        if (stb && direction == 0) brightness <= brightness - 1;
    end

    always_ff @(posedge clk) begin
        if (sw[0] == 0) begin
            led_r0_duty <= 0;
            led_g0_duty <= brightness;
            led_b0_duty <= brightness;
        end else begin
            led_r0_duty <= 64;
            led_g0_duty <= 0;
            led_b0_duty <= 64;
        end
    end
endmodule
