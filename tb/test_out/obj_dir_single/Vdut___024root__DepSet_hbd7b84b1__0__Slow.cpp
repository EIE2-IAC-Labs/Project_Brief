// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdut.h for the primary calling header

#include "Vdut__pch.h"
#include "Vdut__Syms.h"
#include "Vdut___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vdut___024root___dump_triggers__stl(Vdut___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vdut___024root___eval_triggers__stl(Vdut___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval_triggers__stl\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered.setBit(0U, (IData)(vlSelfRef.__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vdut___024root___dump_triggers__stl(vlSelf);
    }
#endif
}

VL_ATTR_COLD void Vdut___024root___stl_sequent__TOP__0(Vdut___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___stl_sequent__TOP__0\n"); );
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.a0 = vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf
        [0xaU];
    vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0 
        = (1U & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                 [(0xfffU & ((IData)(3U) + vlSelfRef.top__DOT__PC))] 
                 >> 7U));
    vlSelfRef.top__DOT__opcode = (0x7fU & vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                  [(0xfffU & vlSelfRef.top__DOT__PC)]);
    vlSelfRef.top__DOT__funct3 = (7U & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                        [(0xfffU & 
                                          ((IData)(1U) 
                                           + vlSelfRef.top__DOT__PC))] 
                                        >> 4U));
    vlSelfRef.top__DOT__funct7 = (0x7fU & (vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                           [(0xfffU 
                                             & ((IData)(3U) 
                                                + vlSelfRef.top__DOT__PC))] 
                                           >> 1U));
    vlSelfRef.__VdfgRegularize_h7cd686f0_0_0 = ((vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                 [(0xfffU 
                                                   & ((IData)(1U) 
                                                      + vlSelfRef.top__DOT__PC))] 
                                                 << 8U) 
                                                | vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                [(0xfffU 
                                                  & vlSelfRef.top__DOT__PC)]);
    vlSelfRef.top__DOT__RegWrite = 0U;
    vlSelfRef.top__DOT__MemWrite = 0U;
    vlSelfRef.top__DOT__control__DOT__MemRead = 0U;
    vlSelfRef.top__DOT__ALUSrc = 0U;
    vlSelfRef.top__DOT__Branch = 0U;
    vlSelfRef.top__DOT__Jump = 0U;
    vlSelfRef.top__DOT__Jalr = 0U;
    vlSelfRef.top__DOT__ImmSrc = 0U;
    vlSelfRef.top__DOT__ResultSrc = 0U;
    vlSelfRef.top__DOT__ALUControl = 0U;
    if ((0x40U & (IData)(vlSelfRef.top__DOT__opcode))) {
        if ((0x20U & (IData)(vlSelfRef.top__DOT__opcode))) {
            if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                          >> 4U)))) {
                if ((8U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                                vlSelfRef.top__DOT__RegWrite = 1U;
                                vlSelfRef.top__DOT__MemWrite = 0U;
                                vlSelfRef.top__DOT__Jump = 1U;
                                vlSelfRef.top__DOT__ImmSrc = 4U;
                                vlSelfRef.top__DOT__ResultSrc = 2U;
                                vlSelfRef.top__DOT__ALUControl = 0U;
                            }
                        }
                    }
                } else if ((4U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                            if ((0U == (IData)(vlSelfRef.top__DOT__funct3))) {
                                vlSelfRef.top__DOT__RegWrite = 1U;
                                vlSelfRef.top__DOT__MemWrite = 0U;
                                vlSelfRef.top__DOT__ALUSrc = 1U;
                                vlSelfRef.top__DOT__Jalr = 1U;
                                vlSelfRef.top__DOT__ImmSrc = 0U;
                                vlSelfRef.top__DOT__ResultSrc = 2U;
                                vlSelfRef.top__DOT__ALUControl = 0U;
                            }
                        }
                    }
                } else if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        vlSelfRef.top__DOT__RegWrite = 0U;
                        vlSelfRef.top__DOT__MemWrite = 0U;
                        vlSelfRef.top__DOT__ALUSrc = 0U;
                        vlSelfRef.top__DOT__Branch = 1U;
                        vlSelfRef.top__DOT__ImmSrc = 2U;
                        if ((1U & (~ VL_ONEHOT_I(((
                                                   (7U 
                                                    == (IData)(vlSelfRef.top__DOT__funct3)) 
                                                   << 1U) 
                                                  | (1U 
                                                     == (IData)(vlSelfRef.top__DOT__funct3))))))) {
                            if ((0U != (((7U == (IData)(vlSelfRef.top__DOT__funct3)) 
                                         << 1U) | (1U 
                                                   == (IData)(vlSelfRef.top__DOT__funct3))))) {
                                if (VL_UNLIKELY((vlSymsp->_vm_contextp__->assertOn()))) {
                                    VL_WRITEF_NX("[%0t] %%Error: control_unit.sv:117: Assertion failed in %Ntop.control: unique case, but multiple matches found for '3'h%x'\n",0,
                                                 64,
                                                 VL_TIME_UNITED_Q(1),
                                                 -12,
                                                 vlSymsp->name(),
                                                 3,
                                                 (IData)(vlSelfRef.top__DOT__funct3));
                                    VL_STOP_MT("../rtl/shared/control_unit.sv", 117, "");
                                }
                            }
                        }
                        if ((1U == (IData)(vlSelfRef.top__DOT__funct3))) {
                            vlSelfRef.top__DOT__ALUControl = 1U;
                        } else if ((7U == (IData)(vlSelfRef.top__DOT__funct3))) {
                            vlSelfRef.top__DOT__ALUControl = 3U;
                        } else {
                            vlSelfRef.top__DOT__Branch = 0U;
                        }
                    }
                }
            }
        }
    } else if ((0x20U & (IData)(vlSelfRef.top__DOT__opcode))) {
        if ((0x10U & (IData)(vlSelfRef.top__DOT__opcode))) {
            if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                          >> 3U)))) {
                if ((4U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                            vlSelfRef.top__DOT__RegWrite = 1U;
                            vlSelfRef.top__DOT__ALUSrc = 1U;
                            vlSelfRef.top__DOT__ImmSrc = 3U;
                            vlSelfRef.top__DOT__ResultSrc = 0U;
                            vlSelfRef.top__DOT__ALUControl = 2U;
                        }
                    }
                } else if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        if (((0U == (IData)(vlSelfRef.top__DOT__funct3)) 
                             & (0U == (IData)(vlSelfRef.top__DOT__funct7)))) {
                            vlSelfRef.top__DOT__RegWrite = 1U;
                            vlSelfRef.top__DOT__ALUSrc = 0U;
                            vlSelfRef.top__DOT__ResultSrc = 0U;
                            vlSelfRef.top__DOT__ALUControl = 0U;
                        }
                    }
                }
            }
        } else if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                             >> 3U)))) {
            if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                          >> 2U)))) {
                if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        if ((0U == (IData)(vlSelfRef.top__DOT__funct3))) {
                            vlSelfRef.top__DOT__RegWrite = 0U;
                            vlSelfRef.top__DOT__MemWrite = 1U;
                            vlSelfRef.top__DOT__ALUSrc = 1U;
                            vlSelfRef.top__DOT__ImmSrc = 1U;
                            vlSelfRef.top__DOT__ALUControl = 0U;
                        }
                    }
                }
            }
        }
    } else if ((0x10U & (IData)(vlSelfRef.top__DOT__opcode))) {
        if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                      >> 3U)))) {
            if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                          >> 2U)))) {
                if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                        if ((0U == (IData)(vlSelfRef.top__DOT__funct3))) {
                            vlSelfRef.top__DOT__RegWrite = 1U;
                            vlSelfRef.top__DOT__ALUSrc = 1U;
                            vlSelfRef.top__DOT__ImmSrc = 0U;
                            vlSelfRef.top__DOT__ResultSrc = 0U;
                            vlSelfRef.top__DOT__ALUControl = 0U;
                        }
                    }
                }
            }
        }
    } else if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                         >> 3U)))) {
        if ((1U & (~ ((IData)(vlSelfRef.top__DOT__opcode) 
                      >> 2U)))) {
            if ((2U & (IData)(vlSelfRef.top__DOT__opcode))) {
                if ((1U & (IData)(vlSelfRef.top__DOT__opcode))) {
                    if ((4U == (IData)(vlSelfRef.top__DOT__funct3))) {
                        vlSelfRef.top__DOT__RegWrite = 1U;
                        vlSelfRef.top__DOT__MemWrite = 0U;
                        vlSelfRef.top__DOT__control__DOT__MemRead = 1U;
                        vlSelfRef.top__DOT__ALUSrc = 1U;
                        vlSelfRef.top__DOT__ImmSrc = 0U;
                        vlSelfRef.top__DOT__ResultSrc = 1U;
                        vlSelfRef.top__DOT__ALUControl = 0U;
                    }
                }
            }
        }
    }
    vlSelfRef.__VdfgRegularize_h7cd686f0_0_1 = ((vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                                 [(0xfffU 
                                                   & ((IData)(2U) 
                                                      + vlSelfRef.top__DOT__PC))] 
                                                 << 0x10U) 
                                                | (IData)(vlSelfRef.__VdfgRegularize_h7cd686f0_0_0));
    vlSelfRef.top__DOT__data_path__DOT__SrcA = ((0U 
                                                 == 
                                                 (0x1fU 
                                                  & (vlSelfRef.__VdfgRegularize_h7cd686f0_0_1 
                                                     >> 0xfU)))
                                                 ? 0U
                                                 : 
                                                vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf
                                                [(0x1fU 
                                                  & (vlSelfRef.__VdfgRegularize_h7cd686f0_0_1 
                                                     >> 0xfU))]);
    vlSelfRef.top__DOT__Instr = ((vlSelfRef.top__DOT__instruction_memory__DOT__rom_array
                                  [(0xfffU & ((IData)(3U) 
                                              + vlSelfRef.top__DOT__PC))] 
                                  << 0x18U) | vlSelfRef.__VdfgRegularize_h7cd686f0_0_1);
    vlSelfRef.top__DOT__WriteData = ((0U == (0x1fU 
                                             & (vlSelfRef.top__DOT__Instr 
                                                >> 0x14U)))
                                      ? 0U : vlSelfRef.top__DOT__data_path__DOT__RF__DOT__rf
                                     [(0x1fU & (vlSelfRef.top__DOT__Instr 
                                                >> 0x14U))]);
    vlSelfRef.top__DOT__ImmExt = ((4U & (IData)(vlSelfRef.top__DOT__ImmSrc))
                                   ? ((2U & (IData)(vlSelfRef.top__DOT__ImmSrc))
                                       ? 0U : ((1U 
                                                & (IData)(vlSelfRef.top__DOT__ImmSrc))
                                                ? 0U
                                                : (
                                                   ((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                                                    << 0x14U) 
                                                   | (((0xff000U 
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
                                                            >> 0x14U))))))
                                   : ((2U & (IData)(vlSelfRef.top__DOT__ImmSrc))
                                       ? ((1U & (IData)(vlSelfRef.top__DOT__ImmSrc))
                                           ? (0xfffff000U 
                                              & vlSelfRef.top__DOT__Instr)
                                           : (((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                                               << 0xdU) 
                                              | ((((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0) 
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
                                                          << 1U))))))
                                       : ((1U & (IData)(vlSelfRef.top__DOT__ImmSrc))
                                           ? (((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                                               << 0xcU) 
                                              | (((IData)(vlSelfRef.top__DOT__funct7) 
                                                  << 5U) 
                                                 | (0x1fU 
                                                    & ((IData)(vlSelfRef.__VdfgRegularize_h7cd686f0_0_0) 
                                                       >> 7U))))
                                           : (((- (IData)((IData)(vlSelfRef.top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0))) 
                                               << 0xcU) 
                                              | (vlSelfRef.top__DOT__Instr 
                                                 >> 0x14U)))));
    vlSelfRef.top__DOT__data_path__DOT__SrcB = ((IData)(vlSelfRef.top__DOT__ALUSrc)
                                                 ? vlSelfRef.top__DOT__ImmExt
                                                 : vlSelfRef.top__DOT__WriteData);
    vlSelfRef.top__DOT__ALUResult = ((4U & (IData)(vlSelfRef.top__DOT__ALUControl))
                                      ? 0U : ((2U & (IData)(vlSelfRef.top__DOT__ALUControl))
                                               ? ((1U 
                                                   & (IData)(vlSelfRef.top__DOT__ALUControl))
                                                   ? 
                                                  ((vlSelfRef.top__DOT__data_path__DOT__SrcA 
                                                    < vlSelfRef.top__DOT__data_path__DOT__SrcB)
                                                    ? 1U
                                                    : 0U)
                                                   : vlSelfRef.top__DOT__data_path__DOT__SrcB)
                                               : ((1U 
                                                   & (IData)(vlSelfRef.top__DOT__ALUControl))
                                                   ? 
                                                  (vlSelfRef.top__DOT__data_path__DOT__SrcA 
                                                   - vlSelfRef.top__DOT__data_path__DOT__SrcB)
                                                   : 
                                                  (vlSelfRef.top__DOT__data_path__DOT__SrcA 
                                                   + vlSelfRef.top__DOT__data_path__DOT__SrcB))));
    vlSelfRef.top__DOT__PCNext = ((IData)(vlSelfRef.top__DOT__Jalr)
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
                                          + vlSelfRef.top__DOT__PC)));
}
