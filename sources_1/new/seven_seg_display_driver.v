`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2018 16:57:59
// Design Name: 
// Module Name: seven_seg_display_driver
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


`define CNTR_BITS 21

module seven_seg_display_driver
   #(parameter          CNTR_STEP = 1)  // For simulation
    (input              clk,            // Clock
    input  [15:0]       disp_buf,       // Display buffer
    input  [2:0]        dp,             // Which segment to show the decimal point, 0 for none.
    input  [3:0]        lum,            // Luminosity, display brightness, 0 to 15
    output reg [3:0]    an_mux,         // Seven seg anode driver
    output reg [6:0]    seg_mux,        // Seven seg cathode driver
    output reg          dp_mux          // Decimal point driver
    );
    
    reg  [`CNTR_BITS-1:0] r_refresh_cntr = 0;   // Clock divider used to refresh the display
    wire [3:0]  w_display_digit;                // Encoded digit to display
    wire [3:0]  w_active_anode;                 // Current active display
    wire [6:0]  w_active_cathodes;
    wire [1:0]  w_display_counter;
    wire        w_pwm;
    
    // CLock divider
    always @(posedge clk)
        r_refresh_cntr = r_refresh_cntr + CNTR_STEP;
    
    // Select the buffered digit to display
    function [3:0] get_display_digit;
        input [15:0] in_buf;
        input [1:0]  selector;
        case (selector)
            2'b11: get_display_digit = in_buf[15:12];
            2'b10: get_display_digit = in_buf[11:8];
            2'b01: get_display_digit = in_buf[7:4];
            2'b00: get_display_digit = in_buf[3:0];
        endcase
    endfunction
    
    // The active display is the top two bits of the main refresh counter.
    assign w_display_counter = r_refresh_cntr[`CNTR_BITS-1:`CNTR_BITS-2];
    
    // Decode which display is active
    two_to_four_decoder decode_anode(.out(w_active_anode), .in(w_display_counter));
    
    // Select the active digit from the buffer to display.
    assign w_display_digit = get_display_digit( .in_buf(disp_buf), .selector(w_display_counter) );
    
    // Encode the digit to be displayed into 7 segment representation
    seven_seg_display_encoder encode_digit(.out(w_active_cathodes), .in(w_display_digit));
    
    // Set the display brightness using the PWM module.
    pwm pwm(.clk(clk), .lum(lum), .pwm(w_pwm));
    
    // Set the outputs. Use registers here to avoid timing problems.
    always @ (posedge clk)
    begin
        if (w_pwm)
            an_mux  <= ~w_active_anode;
        else
            an_mux  <= 4'b1111;
        seg_mux <= ~w_active_cathodes;
        dp_mux  <= ~(w_display_counter == (dp - 1));
    end
endmodule
