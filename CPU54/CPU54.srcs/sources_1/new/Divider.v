`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/10 00:05:40
// Design Name: 
// Module Name: Divider
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


module Divider(clk,rst_n,clk_out);
input clk;                //系统时钟
input rst_n;              //复位信号,低电平有效
output reg clk_out;       //输出适配CPU的时钟

parameter DIVISOR = 50000000;//50,000,000分频
reg [31:0] count=32'd0; 
always @(posedge clk) 
begin 
    if(!rst_n)//复位，count，clk_out清零
    begin
      count <= 1'b0;
      clk_out <= 0;  
    end
    else if(count == DIVISOR) 
    begin 
        count <= 32'd0; 
        clk_out <= ~clk_out; 
    end 
    else
        count <= count+1'b1; 
end
endmodule