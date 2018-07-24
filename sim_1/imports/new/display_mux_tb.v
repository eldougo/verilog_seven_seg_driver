`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2018 16:00:29
// Design Name: 
// Module Name: display_mux_tb
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


module display_mux_tb();
    reg clk = 1'b0;
    reg  [15:0] r_display_buffer = 16'h1234;
    wire [3:0] w_active_display_anode;      // The active 7 seg display decoded
    wire [6:0] w_active_display_cathodes;   // The display elements to light up
    wire       w_dp;
    reg  [3:0] r_pwm_lvl_tb = 4'b0010;
    wire w_pwm_tb;
    
    always #1 clk <= ~clk;
    
    initial
    begin
        $display("%d: Starting", $time);
        
        #500;
        r_display_buffer = 16'h1234;
        $display("%d: h1234", $time);
        
        #500;
        r_display_buffer = #10 16'h2222;
        r_pwm_lvl_tb = 4'b1111;
        $display("%d: h2222", $time);
        
        #500;
        r_display_buffer = #10 16'hffff;
        r_pwm_lvl_tb = 4'b0000;
        $display("%d: h89ab", $time);
        
        #500;
        r_display_buffer = #10 16'h89ab;
        r_pwm_lvl_tb = 4'b1000;
        $display("%d: h89ab", $time);
        
        #500;
        $finish;
    end
    
    seven_seg_display_driver 
       #(.CNTR_STEP(20'h2000)) UUT_mux
        (.clk(clk),
        .disp_buf(r_display_buffer),
        .dp(3'b100),
        .lum(8'hff),
        .an_mux(w_active_display_anode),
        .seg_mux(w_active_display_cathodes),
        .dp_mux(w_dp)
    );
    
    pwm UUT_pwm(.clk(clk), .lum(r_pwm_lvl_tb), .pwm(w_pwm_tb));
    

endmodule
