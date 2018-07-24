`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2018 13:53:01
// Design Name: Pulse Width Mudulator
// Module Name: pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Convert the input level to PWM proportional output.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input       clk,        // Clock
    input [3:0] lum,        // Luminosity, duty cycle, brightness from 0 to 15
    output      pwm         // Puls width modulated output
    );
    
    reg [7:0] r_pwm_cntr = 0;
    
    always @(posedge clk)
        r_pwm_cntr = r_pwm_cntr + 1;
    
    assign pwm =  lum == 0 ? ( r_pwm_cntr < 8'h02 ) : ( r_pwm_cntr[7:4] <= lum);
endmodule
