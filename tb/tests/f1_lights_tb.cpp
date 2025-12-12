#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vdut.h"
#include "../vbuddy.cpp"

#define MAX_SIM_CYC 50000000

int main(int argc, char **argv, char **env) {
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);
    Vdut* top = new Vdut;
    
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("f1_lights.vcd");
 
    if (vbdOpen()!=1) return(-1);
    vbdHeader("F1 RISC-V CPU");
    
    top->clk = 1;
    top->rst = 1;
    top->trigger = 0;
    
    for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
        // Toggle clock
        for (tick=0; tick<2; tick++) {
            tfp->dump(2*simcyc+tick);
            top->clk = !top->clk;
            top->eval();
        }
        
        // Reset for first 2 cycles
        if (simcyc < 2) {
            top->rst = 1;
        } else {
            top->rst = 0;
        }
        
        // Display F1 light pattern on neopixel bar
        vbdBar(top->a0 & 0xFF);
        
        // Also display on hex for debugging
        vbdHex(4, (top->a0 >> 4) & 0xF);
        vbdHex(3, top->a0 & 0xF);
        
        // Update cycle count
        vbdCycle(simcyc);
        
        // Check for quit
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
            exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}