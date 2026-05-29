# MIPS CPU Design

基于 Verilog HDL 实现的单周期 MIPS CPU 设计项目，包含 31 条指令与 54 条指令两种 CPU 实现，并完成 Vivado 仿真验证与 FPGA 下板测试。

## Introduction

本项目基于计算机组成原理课程设计，实现了单周期 MIPS CPU 的完整数据通路与控制器设计。
CPU 采用 Verilog HDL 建模，在 Vivado 平台完成仿真与验证，并通过 MARS 汇编结果进行对拍测试。

项目包含：

* 31 条 MIPS 指令 CPU
* 54 条 MIPS 指令扩展 CPU
* 数据通路设计
* 控制器设计
* ALU 与寄存器堆实现
* 指令译码模块
* 仿真测试与 FPGA 下板验证

## Features

### 31 条指令 CPU

支持：

* 算术运算指令
* 逻辑运算指令
* 移位指令
* 访存指令
* 分支跳转指令
* 立即数指令

包括：

```text id="nm1k85"
ADD ADDU SUB SUBU
AND OR XOR NOR
SLT SLTU
SLL SRL SRA
SLLV SRLV SRAV
ADDI ADDIU
ANDI ORI XORI
LW SW
BEQ BNE
SLTI SLTIU
LUI
J JAL JR
```

---

### 54 条指令扩展 CPU

在 31 条指令基础上进一步扩展：

```text id="5w5p6z"
CLZ
JALR
MTHI MTLO
MFHI MFLO
SB SH
LB LH LBU LHU
ERET
BREAK SYSCALL
TEQ
MFC0 MTC0
MUL MULTU
DIV DIVU
BGEZ
```

新增：

* HI/LO 寄存器
* CP0 协处理器
* 乘除法模块
* 异常与中断支持
* 字节/半字访存支持

## Project Structure

```text id="l6wkvl"
├── MIPS-31-CPU/          # 31 instructions single-cycle CPU
├── MIPS-54-CPU/          # 54 instructions extended CPU
├── docs/                 # experiment reports and diagrams
└── README.md
```

## Core Modules

项目主要模块包括：

* CPU Top Module
* Decoder
* Controller
* ALU
* RegFile
* PC
* IMEM / DMEM
* HI_LO
* CP0
* MUL / DIV

其中 CPU 顶层模块负责连接数据通路与控制逻辑，实现完整单周期指令执行流程。

## Development Environment

* Verilog HDL
* Vivado 2016.2
* MARS MIPS Simulator
* FPGA Development Board

## Verification

项目通过以下方式完成验证：

* Vivado 仿真波形验证
* Testbench 自动输出寄存器结果
* 与 MARS 汇编运行结果对拍
* FPGA 下板测试

实验结果表明：

* CPU 能正确执行 MIPS 指令
* 数据通路与控制逻辑运行正常
* 扩展指令与异常处理功能正确实现

## Highlights

* 完整实现单周期 MIPS CPU
* 支持 54 条 MIPS 指令扩展
* 实现异常处理与 CP0
* 支持乘除法与 HI/LO 寄存器
* 完成仿真、对拍与 FPGA 验证
* 模块化 Verilog HDL 设计
