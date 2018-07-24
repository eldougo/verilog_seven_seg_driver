`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2018 13:51:07
// Design Name: 
// Module Name: two_to_four_decoder
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


module two_to_four_decoder(
    input      [1:0] in,
    output reg [3:0] out
    );
    
//    // Method 1 using boolean logic:
//    assign out[0] = ~in[0] & ~in[1];
//    assign out[1] = in[0] & ~in[1];
//    assign out[2] = ~in[0] & in[1];
//    assign out[3] = in[0] & in[1];
    
    
//    // Method 2 using case statement:
//    function [6:0] decode2to4;
//        input [3:0] in_digit;
//        begin
//            case (in_digit)
//                2'h0 : decode2to4 = 4'b0001;
//                2'h1 : decode2to4 = 4'b0010;
//                2'h2 : decode2to4 = 4'b0100;
//                2'h3 : decode2to4 = 4'b1000;
//                default: decode2to4 = 4'b0000;
//            endcase
//        end
//    endfunction
    
//    assign out = decode2to4( in );
    
    always @ (in)
    begin
        if      ( in == 2'h0 ) out = 4'b0001;
        else if ( in == 2'h1 ) out = 4'b0010;
        else if ( in == 2'h2 ) out = 4'b0100;
        else                   out = 4'b1000;  // ( in == 2'h3 )
    end
    
endmodule
