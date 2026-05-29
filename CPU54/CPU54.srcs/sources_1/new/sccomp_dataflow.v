`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/09 23:33:00
// Design Name: 
// Module Name: sccomp_dataflow
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

module sccomp_dataflow(
    input clk_in,       //时钟信号
    input reset,        //复位信号
    //output [31:0] inst,
    //output [31:0] pc
    //下板用
    output [7:0]  o_seg,//输出内容
    output [7:0]  o_sel //片选信号
    );

wire [31:0] pc_out;          //输出指令地址
wire [31:0] dm_addr_temp;    //DMEM临时地址
wire [31:0] im_addr_in;     //11位指令码地址
wire [31:0] im_instr_out;   //32位指令码
wire dm_ena;                //是否需要启用DMEM
wire dm_r, dm_w;            //读写指令
wire [31:0] dm_addr;        //需要用到的DMEM地址
wire [31:0] dm_data_out;    //DMEM读取时读取到的数据
wire [31:0] dm_data_w;      //要写入DMEM的内容 


wire sb_flag;               
wire sh_flag;               
wire sw_flag;               
wire lb_flag;              
wire lh_flag;               
wire lbu_flag;              
wire lhu_flag;              
wire lw_flag;               

assign im_addr_in = pc_out - 32'h00400000;
assign dm_addr = (dm_addr_temp -  32'h10010000)/4;
assign pc = pc_out;
assign inst = im_instr_out;


IMEM imem(
    .im_addr_in(im_addr_in[12:2]),  
    .im_instr_out(im_instr_out)     
    );


DMEM dmem(                          
    .dm_clk(clk_cpu),                
    .dm_ena(dm_ena),                
    .dm_r(dm_r),                    
    .dm_w(dm_w),                   
    .sb_flag(sb_flag),             
    .sh_flag(sh_flag),              
    .sw_flag(sw_flag),              
    .lb_flag(lb_flag),              
    .lh_flag(lh_flag),              
    .lbu_flag(lbu_flag),           
    .lhu_flag(lhu_flag),            
    .lw_flag(lw_flag),              
    .dm_addr(dm_addr[6:0]),         
    .dm_data_in(dm_data_w),         
    .dm_data_out(dm_data_out)       
    );


cpu sccpu(
    .clk(clk_cpu),                   
    .ena(1'b1),                     
    .rst(reset),                   
    .instr_in(im_instr_out),        
    .dm_data(dm_data_out),          
    .dm_ena(dm_ena),                
    .dm_w(dm_w),                   
    .dm_r(dm_r),                    
    .pc_out(pc_out),               
    .dm_addr(dm_addr_temp),         
    .dm_data_w(dm_data_w),           
    .sb_flag(sb_flag),              
    .sh_flag(sh_flag),              
    .sw_flag(sw_flag),             
    .lb_flag(lb_flag),              
    .lh_flag(lh_flag),              
    .lbu_flag(lbu_flag),            
    .lhu_flag(lhu_flag),            
    .lw_flag(lw_flag)               
    );

seg7x16 seg7x16_inst(
    .clk(clk_in),
	.reset(reset),
	.cs(1'b1),
	.i_data(im_instr_out),
	.o_seg(o_seg),
	.o_sel(o_sel)
    );

Divider Divider_inst(
    .clk(clk_in),                   
    .rst_n(~reset),                 
    .clk_out(clk_cpu)               
    );

endmodule
/*module sccomp_dataflow(
    input clk_in,       //时钟信号
    input reset,        //复位信号
    output [31:0] inst, //输出指令
    output [31:0] pc    //执行地址
    );


wire [31:0] pc_out;          //输出指令地址，告诉IMEM要取哪条
wire [31:0] dm_addr_temp;    //DMEM临时地址，需要转化



wire [31:0] im_addr_in;     //11位指令码地址，从IMEM中读指令
wire [31:0] im_instr_out;   //32位指令码

assign im_addr_in = pc_out - 32'h00400000;


wire dm_ena;                //是否需要启用DMEM
wire dm_r, dm_w;            //读写指令
wire [31:0] dm_addr;        //需要用到的DMEM地址
wire [31:0] dm_data_out;    //DMEM读取时读取到的数据
wire [31:0] dm_data_w;      //要写入DMEM的内容 
wire sb_flag;               //当前写入指令是否是SB发出
wire sh_flag;               //当前写入指令是否是SH发出
wire sw_flag;               //当前写入指令是否是SW发出
wire lb_flag;               //当前读取指令是否是LB发出
wire lh_flag;               //当前读取指令是否是LH发出
wire lbu_flag;              //当前读取指令是否是LBU发出
wire lhu_flag;              //当前读取指令是否是LHU发出
wire lw_flag;               //当前读取指令是否是LW发出

assign dm_addr = dm_addr_temp -  32'h10010000;


assign pc = pc_out;
assign inst = im_instr_out;



IMEM imem(
    .im_addr_in(im_addr_in[12:2]),  //11位指令码地址，从IMEM中读指令
    .im_instr_out(im_instr_out)     //32位指令码
    );


DMEM dmem(                          //DMEM根据性能考量，设计成异步读取数据，同步写入数据的形式
    .dm_clk(clk_in),                //DMEM时钟信号，只在写数据时使用
    .dm_ena(dm_ena),                //使能信号端，高电平有效，有效时才能读取/写入数据
    .dm_r(dm_r),                    //read读信号，读取时拉高
    .dm_w(dm_w),                    //write写信号，写入时拉高
    .sb_flag(sb_flag),              //当前写入指令是否是SB发出
    .sh_flag(sh_flag),              //当前写入指令是否是SH发出
    .sw_flag(sw_flag),              //当前写入指令是否是SW发出
    .lb_flag(lb_flag),              //当前读取指令是否是LB发出
    .lh_flag(lh_flag),              //当前读取指令是否是LH发出
    .lbu_flag(lbu_flag),            //当前读取指令是否是LBU发出
    .lhu_flag(lhu_flag),            //当前读取指令是否是LHU发出
    .lw_flag(lw_flag),              //当前读取指令是否是LW发出
    .dm_addr(dm_addr[6:0]),         //7位地址，要读取/写入的地址
    .dm_data_in(dm_data_w),         //写入时要写入的数据
    .dm_data_out(dm_data_out)       //读取时读取到的数据
    );


cpu sccpu(
    .clk(clk_in),                   //CPU执行时钟
    .ena(1'b1),                     //使能信号端
    .rst(reset),                    //复位信号
    .instr_in(im_instr_out),        //当前要执行的指令
    .dm_data(dm_data_out),          //读取到的DMEM的具体内容
    .dm_ena(dm_ena),                //是否需要启用DMEM
    .dm_w(dm_w),                    //如果启用DMEM，是否为写入
    .dm_r(dm_r),                    //如果启用DMEM，是否为读取
    .pc_out(pc_out),                //输出指令地址，告诉IMEM要取哪条
    .dm_addr(dm_addr_temp),         //需要用到的DMEM地址
    .dm_data_w(dm_data_w),          //要写入DMEM的内容 
    .sb_flag(sb_flag),              //当前写入指令是否是SB发出
    .sh_flag(sh_flag),              //当前写入指令是否是SH发出
    .sw_flag(sw_flag),              //当前写入指令是否是SW发出
    .lb_flag(lb_flag),              //当前读取指令是否是LB发出
    .lh_flag(lh_flag),              //当前读取指令是否是LH发出
    .lbu_flag(lbu_flag),            //当前读取指令是否是LBU发出
    .lhu_flag(lhu_flag),            //当前读取指令是否是LHU发出
    .lw_flag(lw_flag)               //当前读取指令是否是LW发出
    );

endmodule*/