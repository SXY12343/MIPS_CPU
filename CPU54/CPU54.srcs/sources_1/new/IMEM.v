`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 23:37:22
// Design Name: 
// Module Name: IMEM
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

/* 实现了一个指令存储器（IMEM）,它通过输入一个11位的地址，
实例化IP核，从内部的存储单元中读取对应的32位指令码。
这个功能通常用于处理器或CPU的指令存储和取指操作。*/
module IMEM(
    input [10:0] im_addr_in,     //11位指令码地址，从IMEM中读指令
    output [31:0] im_instr_out   //32位指令码
    ); 
    
/* 实例化IP核 */
dist_mem_gen_0 imem(.a(im_addr_in),.spo(im_instr_out));
endmodule