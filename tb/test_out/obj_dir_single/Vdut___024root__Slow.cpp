// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdut.h for the primary calling header

#include "Vdut__pch.h"
#include "Vdut__Syms.h"
#include "Vdut___024root.h"

void Vdut___024root___ctor_var_reset(Vdut___024root* vlSelf);

Vdut___024root::Vdut___024root(Vdut__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vdut___024root___ctor_var_reset(this);
}

void Vdut___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vdut___024root::~Vdut___024root() {
}
