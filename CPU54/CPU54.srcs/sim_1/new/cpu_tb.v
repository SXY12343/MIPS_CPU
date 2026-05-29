`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 23:51:06
// Design Name: 
// Module Name: cpu_tb
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


/*module cpu_tb;
reg clk;            //时钟信号
reg rst;            //复位信号
wire [31:0] inst;   //要执行的指令
wire [31:0] pc;     //下一条指令的地址
reg  [31:0] cnt;    //计数器，已经执行了几条指令
integer file_open;

initial 
begin
    clk = 1'b0;
    rst = 1'b1;
    #50 rst = 1'b0;
    cnt = 0;
end

always  #10 clk = ~clk;

always @ (posedge clk) begin
    cnt <= cnt + 1'b1;
    file_open = $fopen("D://t545454", "a+");
    $fdisplay(file_open, "OP: %d", cnt);
    $fdisplay(file_open, "Instr_addr = %h", sc_inst.inst);
    $fdisplay(file_open, "$zero = %h", sc_inst.sccpu.cpu_ref.array_reg[0]);
    $fdisplay(file_open, "$at   = %h", sc_inst.sccpu.cpu_ref.array_reg[1]);
    $fdisplay(file_open, "$v0   = %h", sc_inst.sccpu.cpu_ref.array_reg[2]);
    $fdisplay(file_open, "$v1   = %h", sc_inst.sccpu.cpu_ref.array_reg[3]);
    $fdisplay(file_open, "$a0   = %h", sc_inst.sccpu.cpu_ref.array_reg[4]);
    $fdisplay(file_open, "$a1   = %h", sc_inst.sccpu.cpu_ref.array_reg[5]);
    $fdisplay(file_open, "$a2   = %h", sc_inst.sccpu.cpu_ref.array_reg[6]);
    $fdisplay(file_open, "$a3   = %h", sc_inst.sccpu.cpu_ref.array_reg[7]);
    $fdisplay(file_open, "$t0   = %h", sc_inst.sccpu.cpu_ref.array_reg[8]);
    $fdisplay(file_open, "$t1   = %h", sc_inst.sccpu.cpu_ref.array_reg[9]);
    $fdisplay(file_open, "$t2   = %h", sc_inst.sccpu.cpu_ref.array_reg[10]);
    $fdisplay(file_open, "$t3   = %h", sc_inst.sccpu.cpu_ref.array_reg[11]);
    $fdisplay(file_open, "$t4   = %h", sc_inst.sccpu.cpu_ref.array_reg[12]);
    $fdisplay(file_open, "$t5   = %h", sc_inst.sccpu.cpu_ref.array_reg[13]);
    $fdisplay(file_open, "$t6   = %h", sc_inst.sccpu.cpu_ref.array_reg[14]);
    $fdisplay(file_open, "$t7   = %h", sc_inst.sccpu.cpu_ref.array_reg[15]);
    $fdisplay(file_open, "$s0   = %h", sc_inst.sccpu.cpu_ref.array_reg[16]);
    $fdisplay(file_open, "$s1   = %h", sc_inst.sccpu.cpu_ref.array_reg[17]);
    $fdisplay(file_open, "$s2   = %h", sc_inst.sccpu.cpu_ref.array_reg[18]);
    $fdisplay(file_open, "$s3   = %h", sc_inst.sccpu.cpu_ref.array_reg[19]);
    $fdisplay(file_open, "$s4   = %h", sc_inst.sccpu.cpu_ref.array_reg[20]);
    $fdisplay(file_open, "$s5   = %h", sc_inst.sccpu.cpu_ref.array_reg[21]);
    $fdisplay(file_open, "$s6   = %h", sc_inst.sccpu.cpu_ref.array_reg[22]);
    $fdisplay(file_open, "$s7   = %h", sc_inst.sccpu.cpu_ref.array_reg[23]);
    $fdisplay(file_open, "$t8   = %h", sc_inst.sccpu.cpu_ref.array_reg[24]);
    $fdisplay(file_open, "$t9   = %h", sc_inst.sccpu.cpu_ref.array_reg[25]);
    $fdisplay(file_open, "$k0   = %h", sc_inst.sccpu.cpu_ref.array_reg[26]);
    $fdisplay(file_open, "$k1   = %h", sc_inst.sccpu.cpu_ref.array_reg[27]);
    $fdisplay(file_open, "$gp   = %h", sc_inst.sccpu.cpu_ref.array_reg[28]);
    $fdisplay(file_open, "$sp   = %h", sc_inst.sccpu.cpu_ref.array_reg[29]);
    $fdisplay(file_open, "$fp   = %h", sc_inst.sccpu.cpu_ref.array_reg[30]);
    $fdisplay(file_open, "$ra   = %h", sc_inst.sccpu.cpu_ref.array_reg[31]);

    $fdisplay(file_open, "$pc   = %h\n", sc_inst.pc);
    $fclose(file_open);
end

sccomp_dataflow sc_inst(
    .clk_in(clk),
    .reset(rst),
    .inst(inst),
    .pc(pc)
);

endmodule*/

module cpu_tb;//下板用
reg clk;            //时钟信号
reg rst;            //复位信号
wire [31:0] inst;   //要执行的指令
wire [31:0] pc;     //下一条指令的地址
wire [7:0]  o_seg;  //输出内容
wire [7:0]  o_sel;  //片选信号
wire clk_cpu;
//integer file_open;

initial 
begin
    clk = 1'b0;
    rst = 1'b1;
    #50 rst = 1'b0;
end

always  #10 clk = ~clk;
sccomp_dataflow sc_inst(
    .clk_in(clk),
    .reset(rst),
   // .clk_cpu(clk_cpu),
    //.inst(inst), //输出指令
    //.pc(pc),   //执行地址
    .o_seg(o_seg),//输出内容
    .o_sel(o_sel) //片选信号
);
endmodule