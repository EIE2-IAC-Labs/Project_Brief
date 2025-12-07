#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vdut.h"
#include "../vbuddy.cpp"
#include <string>
#include <cctype>
#include <unistd.h>  // for usleep

#define MAX_SIM_CYC 100000000

// Added delay because the graphs were being displayed too quick for my liking - can control that delay or remove it entirely
#define DELAY_US 10000  // 1ms delay = 1000 microseconds (adjust this to control speed of display)

int main(int argc, char **argv, char **env) {
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);
    Vdut* top = new Vdut;
    
    // Get distribution name from command line argument
    std::string dist_name = "Gaussian";  // default
    if (argc > 1) {
        dist_name = argv[1];
        // Capitalize first letter
        if (!dist_name.empty()) {
            dist_name[0] = std::toupper(dist_name[0]);
        }
    }
    
    // Create header string
    std::string header = "PDF: " + dist_name;
    
    // Enable waveform tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");
 
    // Initialize Vbuddy
    if (vbdOpen()!=1) return(-1);
    vbdHeader(header.c_str());
    
    // Initialize signals
    top->clk = 1;
    top->rst = 1;
    top->trigger = 0;
    
    bool displaying = false;
    int original_a0 = 0;
    int plot_counter = 0;
    
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
            original_a0 = top->a0;  // Record initial a0 value
        } else {
            top->rst = 0;
        }
        
        // Detect when display phase starts (a0 changes from original value)
        if (!displaying && top->a0 != original_a0) {
            displaying = true;
        }
        
        // Plot only during display phase
        if (displaying) {
            plot_counter++;
            // Plot every 3rd cycle (because display loop takes 3 instructions per bin)
            if (plot_counter % 3 == 0) {
                vbdPlot(top->a0 & 0xFF, 0, 255);
                usleep(DELAY_US);  // Add delay to slow down visualization
            }
        }
        
        // Check for quit
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) {
            break;
        }
    }

    vbdClose();
    tfp->close();
    exit(0);
}