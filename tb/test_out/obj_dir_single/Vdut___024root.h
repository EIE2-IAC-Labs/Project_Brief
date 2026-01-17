// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vdut.h for the primary calling header

#ifndef VERILATED_VDUT___024ROOT_H_
#define VERILATED_VDUT___024ROOT_H_  // guard

#include "verilated.h"


class Vdut__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vdut___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(trigger,0,0);
    CData/*0:0*/ top__DOT__MemWrite;
    CData/*0:0*/ top__DOT__RegWrite;
    CData/*0:0*/ top__DOT__ALUSrc;
    CData/*0:0*/ top__DOT__Branch;
    CData/*0:0*/ top__DOT__Jump;
    CData/*0:0*/ top__DOT__Jalr;
    CData/*2:0*/ top__DOT__ImmSrc;
    CData/*1:0*/ top__DOT__ResultSrc;
    CData/*2:0*/ top__DOT__ALUControl;
    CData/*6:0*/ top__DOT__opcode;
    CData/*2:0*/ top__DOT__funct3;
    CData/*6:0*/ top__DOT__funct7;
    CData/*0:0*/ top__DOT__control__DOT__MemRead;
    CData/*0:0*/ top__DOT__data_path__DOT__ext__DOT____VdfgRegularize_h6963ae0e_0_0;
    CData/*7:0*/ __VdlyVal__top__DOT__data_memory__DOT__ram_array__v0;
    CData/*0:0*/ __VdlySet__top__DOT__data_memory__DOT__ram_array__v0;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__rst__0;
    CData/*0:0*/ __VactContinue;
    SData/*15:0*/ __VdfgRegularize_h7cd686f0_0_0;
    VL_OUT(a0,31,0);
    IData/*31:0*/ top__DOT__PC;
    IData/*31:0*/ top__DOT__Instr;
    IData/*31:0*/ top__DOT__ALUResult;
    IData/*31:0*/ top__DOT__WriteData;
    IData/*31:0*/ top__DOT__PCNext;
    IData/*31:0*/ top__DOT__ImmExt;
    IData/*31:0*/ top__DOT__data_path__DOT__SrcA;
    IData/*31:0*/ top__DOT__data_path__DOT__SrcB;
    IData/*31:0*/ top__DOT__data_path__DOT__RF__DOT__unnamedblk1__DOT__i;
    IData/*23:0*/ __VdfgRegularize_h7cd686f0_0_1;
    IData/*16:0*/ __VdlyDim0__top__DOT__data_memory__DOT__ram_array__v0;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*7:0*/, 4096> top__DOT__instruction_memory__DOT__rom_array;
    VlUnpacked<IData/*31:0*/, 32> top__DOT__data_path__DOT__RF__DOT__rf;
    VlUnpacked<CData/*7:0*/, 131072> top__DOT__data_memory__DOT__ram_array;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<2> __VactTriggered;
    VlTriggerVec<2> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vdut__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vdut___024root(Vdut__Syms* symsp, const char* v__name);
    ~Vdut___024root();
    VL_UNCOPYABLE(Vdut___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
