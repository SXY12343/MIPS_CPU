`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 11:37:31
// Design Name: 
// Module Name: pc
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
module pc(
    input clk,
    input reset,
    input[31:0] idata,
    output reg[31:0] odata
    );

    always@(negedge clk or posedge reset)begin
        if(reset==1)begin
             odata<=32'h0040_0000;//Êý¾ÝÓ³Éä
        end
        else begin
            odata<=idata;
        end
    end

endmodule