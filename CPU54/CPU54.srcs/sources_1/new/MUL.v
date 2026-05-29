`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 23:41:06
// Design Name: 
// Module Name: MUL
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


/*module MUL(
    input sign_flag,    //是否是有符号乘法
    input [31:0] A,     //输入的乘数A
    input [31:0] B,     //输入的乘数B
    output [31:0] HI,   //高32位结果
    output [31:0] LO    //低32位结果
    );


wire [63:0] result;                 //结果统一存储在result中
wire [63:0] unsigned_result;        //保存无符号乘法结果
wire signed [63:0] signed_result;   //保存有符号乘法结果
wire [63:0] unsigned_A;             //扩展的无符号A
wire [63:0] unsigned_B;             //扩展的无符号B
wire signed [63:0] signed_A;        //扩展的有符号A
wire signed [63:0] signed_B;        //扩展的有符号B

assign unsigned_A = { 32'd0, A };
assign unsigned_B = { 32'd0, B };
assign unsigned_result = unsigned_A * unsigned_B;

assign signed_A = { {32{A[31]}} , A };
assign signed_B = { {32{B[31]}} , B };
assign signed_result = signed_A * signed_B;

assign result = sign_flag ? signed_result : unsigned_result;

assign HI = result[63:32];
assign LO = result[31:0];
endmodule*/
/*乘法器，可以有符号或无符号乘法运算，
这个过程的结果从32位变成64位，然后分别表示高32位，低32位的结果*/
module MUL(
    input sign_flag,    // 是否是有符号乘法
    input [31:0] A,     // 输入的乘数A
    input [31:0] B,     // 输入的乘数B
    output [31:0] HI,   // 高32位结果
    output [31:0] LO    // 低32位结果
    );

/* 内部信号 */
wire [63:0] result_mux;                // 统一存储乘法结果
wire [63:0] result_unsigned;           // 无符号乘法结果
wire signed [63:0] result_signed;      // 有符号乘法结果
wire [63:0] A_unsigned_ext;            // 扩展的无符号A
wire [63:0] B_unsigned_ext;            // 扩展的无符号B
wire signed [63:0] A_signed_ext;       // 扩展的有符号A
wire signed [63:0] B_signed_ext;       // 扩展的有符号B

/* 扩展输入 */
assign A_unsigned_ext = { 32'd0, A };
assign B_unsigned_ext = { 32'd0, B };
assign A_signed_ext = { {32{A[31]}} , A };
assign B_signed_ext = { {32{B[31]}} , B };

/* 乘法运算 */
assign result_unsigned = A_unsigned_ext * B_unsigned_ext;
assign result_signed = A_signed_ext * B_signed_ext;
assign result_mux = sign_flag ? result_signed : result_unsigned;

/* 输出结果 */
assign HI = result_mux[63:32];
assign LO = result_mux[31:0];

endmodule
