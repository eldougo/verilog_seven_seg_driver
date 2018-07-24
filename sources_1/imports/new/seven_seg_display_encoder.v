`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2018 14:42:43
// Design Name: 
// Module Name: seven_seg_display_encoder
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


module seven_seg_display_encoder(
    input      [3:0] in,
    output reg [6:0] out
    );

    // Case statements cause timing violations.
    always @ (in)
    begin
        case (in)
            4'h0 :    out <= 7'h3F;
            4'h1 :    out <= 7'h06;
            4'h2 :    out <= 7'h5B;
            4'h3 :    out <= 7'h4F;
            4'h4 :    out <= 7'h66;
            4'h5 :    out <= 7'h6D;
            4'h6 :    out <= 7'h7D;
            4'h7 :    out <= 7'h07;
            4'h8 :    out <= 7'h7F;
            4'h9 :    out <= 7'h6F;
            4'ha :    out <= 7'h77;
            4'hb :    out <= 7'h7C;
            4'hc :    out <= 7'h39;
            4'hd :    out <= 7'h5E;
            4'he :    out <= 7'h79;
            4'hf :    out <= 7'h71;
            default : out <= 7'h00;
        endcase
    end
endmodule
