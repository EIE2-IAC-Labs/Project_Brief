// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vdut__Syms.h"


void Vdut___024root__trace_chg_0_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vdut___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_chg_0\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vdut___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vdut___024root__trace_chg_0_sub_0(Vdut___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_chg_0_sub_0\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U]))) {
        bufp->chgIData(oldp+0,(vlSelfRef.top__DOT__PC),32);
        bufp->chgIData(oldp+1,(vlSelfRef.top__DOT__Instr),32);
        bufp->chgIData(oldp+2,(vlSelfRef.top__DOT__ALUResult),32);
        bufp->chgIData(oldp+3,(vlSelfRef.top__DOT__WriteData),32);
        bufp->chgBit(oldp+4,(vlSelfRef.top__DOT__MemWrite));
        bufp->chgBit(oldp+5,(vlSelfRef.top__DOT__RegWrite));
        bufp->chgBit(oldp+6,(vlSelfRef.top__DOT__ALUSrc));
        bufp->chgBit(oldp+7,(vlSelfRef.top__DOT__Branch));
        bufp->chgBit(oldp+8,(vlSelfRef.top__DOT__Jump));
        bufp->chgBit(oldp+9,(vlSelfRef.top__DOT__Jalr));
        bufp->chgCData(oldp+10,(vlSelfRef.top__DOT__ImmSrc),3);
        bufp->chgCData(oldp+11,(vlSelfRef.top__DOT__ResultSrc),2);
        bufp->chgCData(oldp+12,(vlSelfRef.top__DOT__ALUControl),3);
        bufp->chgBit(oldp+13,((0U == vlSelfRef.top__DOT__ALUResult)));
        bufp->chgIData(oldp+14,(((IData)(4U) + vlSelfRef.top__DOT__PC)),32);
        bufp->chgIData(oldp+15,((vlSelfRef.top__DOT__ImmExt 
                                 + vlSelfRef.top__DOT__PC)),32);
        bufp->chgIData(oldp+16,(((IData)(vlSelfRef.top__DOT__Jalr)
                                  ? vlSelfRef.top__DOT__ALUResult
                                  : ((((1U == (IData)(vlSelfRef.top__DOT__funct3))
                                        ? ((0U != vlSelfRef.top__DOT__ALUResult) 
                                           & (IData)(vlSelfRef.top__DOT__Branch))
                                        : ((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                           & ((IData)(vlSelfRef.top__DOT__Branch) 
                                              & (0U 
                                                 == vlSelfRef.top__DOT__ALUResult)))) 
                                      | (IData)(vlSelfRef.top__DOT__Jump))
                                      ? (vlSelfRef.top__DOT__ImmExt 
                                         + vlSelfRef.top__DOT__PC)
                                      : ((IData)(4U) 
                                         + vlSelfRef.top__DOT__PC)))),32);
        bufp->chgBit(oldp+17,((((1U == (IData)(vlSelfRef.top__DOT__funct3))
                                 ? ((0U != vlSelfRef.top__DOT__ALUResult) 
                                    & (IData)(vlSelfRef.top__DOT__Branch))
                                 : ((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                    & ((IData)(vlSelfRef.top__DOT__Branch) 
                                       & (0U == vlSelfRef.top__DOT__ALUResult)))) 
                               | (IData)(vlSelfRef.top__DOT__Jump))));
        bufp->chgIData(oldp+18,(vlSelfRef.top__DOT__ImmExt),32);
        bufp->chgCData(oldp+19,(vlSelfRef.top__DOT__opcode),7);
        bufp->chgCData(oldp+20,(vlSelfRef.top__DOT__funct3),3);
        bufp->chgCData(oldp+21,(vlSelfRef.top__DOT__funct7),7);
        bufp->chgBit(oldp+22,(((1U == (IData)(vlSelfRef.top__DOT__funct3))
                                ? ((0U != vlSelfRef.top__DOT__ALUResult) 
                                   & (IData)(vlSelfRef.top__DOT__Branch))
                                : ((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                   & ((IData)(vlSelfRef.top__DOT__Branch) 
                                      & (0U == vlSelfRef.top__DOT__ALUResult))))));
        bufp->chgBit(oldp+23,(vlSelfRef.top__DOT__control__DOT__MemRead));
        bufp->chgIData(oldp+24,((0x1ffffU & vlSelfRef.top__DOT__ALUResult)),17);
        bufp->chgIData(oldp+25,(vlSelfRef.top__DOT__data_path__DOT__SrcA),32);
        bufp->chgIData(oldp+26,(vlSelfRef.top__DOT__data_path__DOT__SrcB),32);
        bufp->chgCData(oldp+27,((0x1fU & (vlSelfRef.__VdfgRegularize_h7cd686f0_0_1 
                                          >> 0xfU))),5);
        bufp->chgCData(oldp+28,((0x1fU & (vlSelfRef.top__DOT__Instr 
                                          >> 0x14U))),5);
        bufp->chgCData(oldp+29,((0x1fU & ((IData)(vlSelfRef.__VdfgRegularize_h7cd686f0_0_0) 
                                          >> 7U))),5);
        bufp->chgIData(oldp+30,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[0]),32);
        bufp->chgIData(oldp+31,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[1]),32);
        bufp->chgIData(oldp+32,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[2]),32);
        bufp->chgIData(oldp+33,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[3]),32);
        bufp->chgIData(oldp+34,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[4]),32);
        bufp->chgIData(oldp+35,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[5]),32);
        bufp->chgIData(oldp+36,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[6]),32);
        bufp->chgIData(oldp+37,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[7]),32);
        bufp->chgIData(oldp+38,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[8]),32);
        bufp->chgIData(oldp+39,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[9]),32);
        bufp->chgIData(oldp+40,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[10]),32);
        bufp->chgIData(oldp+41,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[11]),32);
        bufp->chgIData(oldp+42,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[12]),32);
        bufp->chgIData(oldp+43,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[13]),32);
        bufp->chgIData(oldp+44,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[14]),32);
        bufp->chgIData(oldp+45,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[15]),32);
        bufp->chgIData(oldp+46,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[16]),32);
        bufp->chgIData(oldp+47,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[17]),32);
        bufp->chgIData(oldp+48,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[18]),32);
        bufp->chgIData(oldp+49,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[19]),32);
        bufp->chgIData(oldp+50,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[20]),32);
        bufp->chgIData(oldp+51,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[21]),32);
        bufp->chgIData(oldp+52,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[22]),32);
        bufp->chgIData(oldp+53,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[23]),32);
        bufp->chgIData(oldp+54,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[24]),32);
        bufp->chgIData(oldp+55,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[25]),32);
        bufp->chgIData(oldp+56,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[26]),32);
        bufp->chgIData(oldp+57,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[27]),32);
        bufp->chgIData(oldp+58,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[28]),32);
        bufp->chgIData(oldp+59,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[29]),32);
        bufp->chgIData(oldp+60,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[30]),32);
        bufp->chgIData(oldp+61,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf[31]),32);
        bufp->chgIData(oldp+62,(vlSelfRef.top__DOT__data_path__DOT__RF__DOT__unnamedblk1__DOT__i),32);
        bufp->chgIData(oldp+63,((vlSelfRef.top__DOT__data_path__DOT__SrcA 
                                 + vlSelfRef.top__DOT__data_path__DOT__SrcB)),32);
        bufp->chgIData(oldp+64,((vlSelfRef.top__DOT__data_path__DOT__SrcA 
                                 - vlSelfRef.top__DOT__data_path__DOT__SrcB)),32);
        bufp->chgIData(oldp+65,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                                  << 0xcU) | (vlSelfRef.top__DOT__Instr 
                                              >> 0x14U))),32);
        bufp->chgIData(oldp+66,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                                  << 0xcU) | (((IData)(vlSelfRef.top__DOT__funct7) 
                                               << 5U) 
                                              | (0x1fU 
                                                 & ((IData)(vlSelfRef.__VdfgRegularize_h7cd686f0_0_0) 
                                                    >> 7U))))),32);
        bufp->chgIData(oldp+67,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
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
        bufp->chgIData(oldp+68,((0xfffff000U & vlSelfRef.top__DOT__Instr)),32);
        bufp->chgIData(oldp+69,((((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
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
        bufp->chgSData(oldp+70,(((((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0) 
                                   << 0xcU) | (0x800U 
                                               & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                  [
                                                  (0xfffU 
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
        bufp->chgIData(oldp+71,(((((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0) 
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
        bufp->chgIData(oldp+72,((vlSelfRef.top__DOT__PC 
                                 - (IData)(0xbfc00000U))),32);
    }
    bufp->chgBit(oldp+73,(vlSelfRef.clk));
    bufp->chgBit(oldp+74,(vlSelfRef.rst));
    bufp->chgBit(oldp+75,(vlSelfRef.trigger));
    bufp->chgIData(oldp+76,(vlSelfRef.a0),32);
    bufp->chgIData(oldp+77,(((4U == (IData)(vlSelfRef.top__DOT__funct3))
                              ? vlSelfRef.top__DOT__data_memory__DOT__ram_array
                             [(0x1ffffU & vlSelfRef.top__DOT__ALUResult)]
                              : 0U)),32);
    bufp->chgIData(oldp+78,(((0U == (IData)(vlSelfRef.top__DOT__ResultSrc))
                              ? vlSelfRef.top__DOT__ALUResult
                              : ((1U == (IData)(vlSelfRef.top__DOT__ResultSrc))
                                  ? ((4U == (IData)(vlSelfRef.top__DOT__funct3))
                                      ? vlSelfRef.top__DOT__data_memory__DOT__ram_array
                                     [(0x1ffffU & vlSelfRef.top__DOT__ALUResult)]
                                      : 0U) : ((2U 
                                                == (IData)(vlSelfRef.top__DOT__ResultSrc))
                                                ? ((IData)(4U) 
                                                   + vlSelfRef.top__DOT__PC)
                                                : 0U)))),32);
}

void Vdut___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root__trace_cleanup\n"); );
    // Init
    Vdut___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
