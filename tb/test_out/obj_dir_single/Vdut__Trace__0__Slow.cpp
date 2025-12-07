// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vdut__Syms.h"


VL_ATTR_COLD void Vdut___024root__trace_init_sub__TOP__0(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_init_sub__TOP__0\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushPrefix("$rootio", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+74,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+76,0,"trigger",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+77,0,"a0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("top", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+74,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+76,0,"trigger",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+77,0,"a0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+1,0,"PC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+2,0,"Instr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+3,0,"ALUResult",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+4,0,"WriteData",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+78,0,"ReadData",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+5,0,"MemWrite",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+6,0,"RegWrite",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+7,0,"ALUSrc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+8,0,"Branch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"Jump",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+10,0,"Jalr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+11,0,"ImmSrc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+12,0,"ResultSrc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+13,0,"ALUControl",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+14,0,"Zero",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+15,0,"PCPlus4",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+16,0,"PCTarget",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+17,0,"PCNext",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+18,0,"PCSrc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+19,0,"ImmExt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+20,0,"opcode",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+21,0,"funct3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+22,0,"funct7",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBit(c+23,0,"BranchTaken",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("control", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+20,0,"opcode",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+21,0,"funct3",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+22,0,"funct7",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBit(c+6,0,"RegWrite",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+5,0,"MemWrite",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+24,0,"MemRead",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+7,0,"ALUSrc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+8,0,"Branch",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"Jump",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+10,0,"Jalr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+11,0,"ImmSrc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+12,0,"ResultSrc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+13,0,"ALUControl",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+80,0,"OPC_LOAD",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+81,0,"OPC_STORE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+82,0,"OPC_OP_IMM",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+83,0,"OPC_OP",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+84,0,"OPC_LUI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+85,0,"OPC_BRANCH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+86,0,"OPC_JALR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+87,0,"OPC_JAL",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+88,0,"ALU_ADD",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+89,0,"ALU_SUB",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+90,0,"ALU_PASS_B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+91,0,"ALU_SLTU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+92,0,"RES_ALU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+93,0,"RES_MEM",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+94,0,"RES_PC4",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->popPrefix();
    tracep->pushPrefix("data_memory", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+95,0,"DATA_WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+96,0,"ADDR_WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+74,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+3,0,"addr_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+4,0,"write_data_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+5,0,"write_en_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+21,0,"funct3_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+78,0,"read_data_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+25,0,"byte_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 16,0);
    tracep->popPrefix();
    tracep->pushPrefix("data_path", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+74,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+2,0,"Instr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+78,0,"ReadData",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+15,0,"PCPlus4",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+6,0,"RegWrite",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+12,0,"ResultSrc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+7,0,"ALUSrc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+13,0,"ALUControl",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+11,0,"ImmSrc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+3,0,"ALUResult",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+4,0,"WriteData",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+14,0,"Zero",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+77,0,"a0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+26,0,"SrcA",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+27,0,"SrcB",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"Result",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+19,0,"ImmExt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("RF", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+74,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+6,0,"WE3",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+28,0,"A1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+29,0,"A2",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+30,0,"A3",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+79,0,"WD3",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+26,0,"RD1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+4,0,"RD2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+77,0,"a0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("rf", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+31+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 31,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+63,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("alu_core", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+13,0,"ALUControl",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+26,0,"SrcA",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+27,0,"SrcB",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+14,0,"Zero",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+3,0,"ALUResult",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+64,0,"sum",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+65,0,"diff",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("ext", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+2,0,"instr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+11,0,"ImmSrc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+19,0,"ImmExt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+66,0,"imm_i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+67,0,"imm_s",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+68,0,"imm_b",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+69,0,"imm_u",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+70,0,"imm_j",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+71,0,"imm_b_raw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 12,0);
    tracep->declBus(c+72,0,"imm_j_raw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 20,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("ext_for_pc", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+2,0,"instr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+11,0,"ImmSrc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+19,0,"ImmExt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+66,0,"imm_i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+67,0,"imm_s",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+68,0,"imm_b",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+69,0,"imm_u",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+70,0,"imm_j",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+71,0,"imm_b_raw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 12,0);
    tracep->declBus(c+72,0,"imm_j_raw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 20,0);
    tracep->popPrefix();
    tracep->pushPrefix("instruction_memory", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+95,0,"ADDRESS_WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+97,0,"DATA_WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+95,0,"OUT_WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+1,0,"addr_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+2,0,"instr_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+73,0,"offset_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("pc_register", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+74,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+17,0,"pc_next",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+1,0,"pc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vdut___024root__trace_init_top(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_init_top\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vdut___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vdut___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vdut___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vdut___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vdut___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vdut___024root__trace_register(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_register\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vdut___024root__trace_const_0, 0U, vlSelf);
    tracep->addFullCb(&Vdut___024root__trace_full_0, 0U, vlSelf);
    tracep->addChgCb(&Vdut___024root__trace_chg_0, 0U, vlSelf);
    tracep->addCleanupCb(&Vdut___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vdut___024root__trace_const_0_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vdut___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_const_0\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vdut___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vdut___024root__trace_const_0_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_const_0_sub_0\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullCData(oldp+80,(3U),7);
    bufp->fullCData(oldp+81,(0x23U),7);
    bufp->fullCData(oldp+82,(0x13U),7);
    bufp->fullCData(oldp+83,(0x33U),7);
    bufp->fullCData(oldp+84,(0x37U),7);
    bufp->fullCData(oldp+85,(0x63U),7);
    bufp->fullCData(oldp+86,(0x67U),7);
    bufp->fullCData(oldp+87,(0x6fU),7);
    bufp->fullCData(oldp+88,(0U),3);
    bufp->fullCData(oldp+89,(1U),3);
    bufp->fullCData(oldp+90,(2U),3);
    bufp->fullCData(oldp+91,(3U),3);
    bufp->fullCData(oldp+92,(0U),2);
    bufp->fullCData(oldp+93,(1U),2);
    bufp->fullCData(oldp+94,(2U),2);
    bufp->fullIData(oldp+95,(0x20U),32);
    bufp->fullIData(oldp+96,(0x11U),32);
    bufp->fullIData(oldp+97,(8U),32);
}

VL_ATTR_COLD void Vdut___024root__trace_full_0_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vdut___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_full_0\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vdut___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vdut___024root__trace_full_0_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_full_0_sub_0\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelfRef.top__DOT__PC),32);
    bufp->fullIData(oldp+2,(vlSelfRef.top__DOT__Instr),32);
    bufp->fullIData(oldp+3,(vlSelfRef.top__DOT__ALUResult),32);
    bufp->fullIData(oldp+4,(vlSelfRef.top__DOT__WriteData),32);
    bufp->fullBit(oldp+5,(vlSelfRef.top__DOT__MemWrite));
    bufp->fullBit(oldp+6,(vlSelfRef.top__DOT__RegWrite));
    bufp->fullBit(oldp+7,(vlSelfRef.top__DOT__ALUSrc));
    bufp->fullBit(oldp+8,(vlSelfRef.top__DOT__Branch));
    bufp->fullBit(oldp+9,(vlSelfRef.top__DOT__Jump));
    bufp->fullBit(oldp+10,(vlSelfRef.top__DOT__Jalr));
    bufp->fullCData(oldp+11,(vlSelfRef.top__DOT__ImmSrc),3);
    bufp->fullCData(oldp+12,(vlSelfRef.top__DOT__ResultSrc),2);
    bufp->fullCData(oldp+13,(vlSelfRef.top__DOT__ALUControl),3);
    bufp->fullBit(oldp+14,((0U == vlSelfRef.top__DOT__ALUResult)));
    bufp->fullIData(oldp+15,(((IData)(4U) + vlSelfRef.top__DOT__PC)),32);
    bufp->fullIData(oldp+16,((vlSelfRef.top__DOT__ImmExt 
                              + vlSelfRef.top__DOT__PC)),32);
    bufp->fullIData(oldp+17,(((IData)(vlSelfRef.top__DOT__Jalr)
                               ? vlSelfRef.top__DOT__ALUResult
                               : ((((1U == (IData)(vlSelfRef.top__DOT__funct3))
                                     ? ((0U != vlSelfRef.top__DOT__ALUResult) 
                                        & (IData)(vlSelfRef.top__DOT__Branch))
                                     : ((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                        & ((IData)(vlSelfRef.top__DOT__Branch) 
                                           & (0U == vlSelfRef.top__DOT__ALUResult)))) 
                                   | (IData)(vlSelfRef.top__DOT__Jump))
                                   ? (vlSelfRef.top__DOT__ImmExt 
                                      + vlSelfRef.top__DOT__PC)
                                   : ((IData)(4U) + vlSelfRef.top__DOT__PC)))),32);
    bufp->fullBit(oldp+18,((((1U == (IData)(vlSelfRef.top__DOT__funct3))
                              ? ((0U != vlSelfRef.top__DOT__ALUResult) 
                                 & (IData)(vlSelfRef.top__DOT__Branch))
                              : ((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                 & ((IData)(vlSelfRef.top__DOT__Branch) 
                                    & (0U == vlSelfRef.top__DOT__ALUResult)))) 
                            | (IData)(vlSelfRef.top__DOT__Jump))));
    bufp->fullIData(oldp+19,(vlSelfRef.top__DOT__ImmExt),32);
    bufp->fullCData(oldp+20,(vlSelfRef.top__DOT__opcode),7);
    bufp->fullCData(oldp+21,(vlSelfRef.top__DOT__funct3),3);
    bufp->fullCData(oldp+22,(vlSelfRef.top__DOT__funct7),7);
    bufp->fullBit(oldp+23,(((1U == (IData)(vlSelfRef.top__DOT__funct3))
                             ? ((0U != vlSelfRef.top__DOT__ALUResult) 
                                & (IData)(vlSelfRef.top__DOT__Branch))
                             : ((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                & ((IData)(vlSelfRef.top__DOT__Branch) 
                                   & (0U == vlSelfRef.top__DOT__ALUResult))))));
    bufp->fullBit(oldp+24,(vlSelfRef.top__DOT__control__DOT__MemRead));
    bufp->fullIData(oldp+25,((0x1ffffU & vlSelfRef.top__DOT__ALUResult)),17);
    bufp->fullIData(oldp+26,(vlSelfRef.top__DOT__data_path__DOT__SrcA),32);
    bufp->fullIData(oldp+27,(vlSelfRef.top__DOT__data_path__DOT__SrcB),32);
    bufp->fullCData(oldp+28,((0x1fU & (vlSelfRef.__VdfgRegularize_h7cd686f0_0_1 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+29,((0x1fU & (vlSelfRef.top__DOT__Instr 
                                       >> 0x14U))),5);
    bufp->fullCData(oldp+30,((0x1fU & ((IData)(vlSelfRef.__VdfgRegularize_h7cd686f0_0_0) 
                                       >> 7U))),5);
    bufp->fullIData(oldp+31,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[0]),32);
    bufp->fullIData(oldp+32,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[1]),32);
    bufp->fullIData(oldp+33,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[2]),32);
    bufp->fullIData(oldp+34,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[3]),32);
    bufp->fullIData(oldp+35,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[4]),32);
    bufp->fullIData(oldp+36,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[5]),32);
    bufp->fullIData(oldp+37,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[6]),32);
    bufp->fullIData(oldp+38,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[7]),32);
    bufp->fullIData(oldp+39,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[8]),32);
    bufp->fullIData(oldp+40,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[9]),32);
    bufp->fullIData(oldp+41,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[10]),32);
    bufp->fullIData(oldp+42,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[11]),32);
    bufp->fullIData(oldp+43,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[12]),32);
    bufp->fullIData(oldp+44,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[13]),32);
    bufp->fullIData(oldp+45,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[14]),32);
    bufp->fullIData(oldp+46,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[15]),32);
    bufp->fullIData(oldp+47,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[16]),32);
    bufp->fullIData(oldp+48,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[17]),32);
    bufp->fullIData(oldp+49,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[18]),32);
    bufp->fullIData(oldp+50,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[19]),32);
    bufp->fullIData(oldp+51,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[20]),32);
    bufp->fullIData(oldp+52,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[21]),32);
    bufp->fullIData(oldp+53,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[22]),32);
    bufp->fullIData(oldp+54,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[23]),32);
    bufp->fullIData(oldp+55,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[24]),32);
    bufp->fullIData(oldp+56,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[25]),32);
    bufp->fullIData(oldp+57,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[26]),32);
    bufp->fullIData(oldp+58,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[27]),32);
    bufp->fullIData(oldp+59,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[28]),32);
    bufp->fullIData(oldp+60,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[29]),32);
    bufp->fullIData(oldp+61,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[30]),32);
    bufp->fullIData(oldp+62,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[31]),32);
    bufp->fullIData(oldp+63,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__unnamedblk1__DOT__i),32);
    bufp->fullIData(oldp+64,((vlSelfRef.top__DOT__data_path__DOT__SrcA 
                              + vlSelfRef.top__DOT__data_path__DOT__SrcB)),32);
    bufp->fullIData(oldp+65,((vlSelfRef.top__DOT__data_path__DOT__SrcA 
                              - vlSelfRef.top__DOT__data_path__DOT__SrcB)),32);
    bufp->fullIData(oldp+66,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                               << 0xcU) | (vlSelfRef.top__DOT__Instr 
                                           >> 0x14U))),32);
    bufp->fullIData(oldp+67,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                               << 0xcU) | (((IData)(vlSelfRef.top__DOT__funct7) 
                                            << 5U) 
                                           | (0x1fU 
                                              & ((IData)(vlSelfRef.__VdfgRegularize_h7cd686f0_0_0) 
                                                 >> 7U))))),32);
    bufp->fullIData(oldp+68,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                               << 0xdU) | ((((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0) 
                                             << 0xcU) 
                                            | (0x800U 
                                               & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                  [
                                                  (0xfffU 
                                                   & vlSelfRef.top__DOT__PC)] 
                                                  << 4U))) 
                                           | ((0x7e0U 
                                               & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                  [
                                                  (0xfffU 
                                                   & ((IData)(3U) 
                                                      + vlSelfRef.top__DOT__PC))] 
                                                  << 4U)) 
                                              | (0x1eU 
                                                 & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                    [
                                                    (0xfffU 
                                                     & ((IData)(1U) 
                                                        + vlSelfRef.top__DOT__PC))] 
                                                    << 1U)))))),32);
    bufp->fullIData(oldp+69,((0xfffff000U & vlSelfRef.top__DOT__Instr)),32);
    bufp->fullIData(oldp+70,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                               << 0x14U) | (((0xff000U 
                                              & vlSelfRef.__VdfgRegularize_h7cd686f0_0_1) 
                                             | (0x800U 
                                                & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                   [
                                                   (0xfffU 
                                                    & ((IData)(2U) 
                                                       + vlSelfRef.top__DOT__PC))] 
                                                   << 7U))) 
                                            | (0x7feU 
                                               & (vlSelfRef.top__DOT__Instr 
                                                  >> 0x14U))))),32);
    bufp->fullSData(oldp+71,(((((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0) 
                                << 0xcU) | (0x800U 
                                            & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                               [(0xfffU 
                                                 & vlSelfRef.top__DOT__PC)] 
                                               << 4U))) 
                              | ((0x7e0U & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                            [(0xfffU 
                                              & ((IData)(3U) 
                                                 + vlSelfRef.top__DOT__PC))] 
                                            << 4U)) 
                                 | (0x1eU & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                             [(0xfffU 
                                               & ((IData)(1U) 
                                                  + vlSelfRef.top__DOT__PC))] 
                                             << 1U))))),13);
    bufp->fullIData(oldp+72,(((((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0) 
                                << 0x14U) | ((0xff000U 
                                              & vlSelfRef.__VdfgRegularize_h7cd686f0_0_1) 
                                             | (0x800U 
                                                & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                   [
                                                   (0xfffU 
                                                    & ((IData)(2U) 
                                                       + vlSelfRef.top__DOT__PC))] 
                                                   << 7U)))) 
                              | (0x7feU & (vlSelfRef.top__DOT__Instr 
                                           >> 0x14U)))),21);
    bufp->fullIData(oldp+73,((vlSelfRef.top__DOT__PC 
                              - (IData)(0xbfc00000U))),32);
    bufp->fullBit(oldp+74,(vlSelfRef.clk));
    bufp->fullBit(oldp+75,(vlSelfRef.rst));
    bufp->fullBit(oldp+76,(vlSelfRef.trigger));
    bufp->fullIData(oldp+77,(vlSelfRef.a0),32);
    bufp->fullIData(oldp+78,(((4U == (IData)(vlSelfRef.top__DOT__funct3))
                               ? vlSelfRef.top__DOT__data_memory__DOT__ram_array
                              [(0x1ffffU & vlSelfRef.top__DOT__ALUResult)]
                               : 0U)),32);
    bufp->fullIData(oldp+79,(((0U == (IData)(vlSelfRef.top__DOT__ResultSrc))
                               ? vlSelfRef.top__DOT__ALUResult
                               : ((1U == (IData)(vlSelfRef.top__DOT__ResultSrc))
                                   ? ((4U == (IData)(vlSelfRef.top__DOT__funct3))
                                       ? vlSelfRef.top__DOT__data_memory__DOT__ram_array
                                      [(0x1ffffU & vlSelfRef.top__DOT__ALUResult)]
                                       : 0U) : ((2U 
                                                 == (IData)(vlSelfRef.top__DOT__ResultSrc))
                                                 ? 
                                                ((IData)(4U) 
                                                 + vlSelfRef.top__DOT__PC)
                                                 : 0U)))),32);
}
