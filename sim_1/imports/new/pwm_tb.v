`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2018 14:01:43
// Design Name: 
// Module Name: pwm_tb
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


module pwm_tb();
    reg  [3:0] r_lvl_tb = 4'b0010;
    reg clk = 1'b0;
    wire w_pwn_tb;
    
    
    always #1 clk <= ~clk;
    
    initial
    begin
        $display("%d: Starting", $time);
        
        r_lvl_tb = #5000 4'b1111;
        $display("%d: b1111", $time);
        
        r_lvl_tb = #5000 4'b1000;
        $display("%d: b1000", $time);
        
        r_lvl_tb = #5000 4'b1110;
        $display("%d: b1110", $time);
        
        r_lvl_tb = #5000 4'b0000;
        $display("%d: b0000", $time);
                
        #5000;
        $finish;
    end
    
    pwm UUT(.clk(clk), .i_lvl(r_lvl_tb), .o_pwm(w_pwn_tb));
    
    
endmodule
