#pragma once

#include "Vdut.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "gtest/gtest.h"

#define MAX_SIM_CYCLES 10000

class CpuTestbench : public ::testing::Test
{
public:
    void SetUp() override
    {
        // Create new context for simulation
        context_ = new VerilatedContext;
        ticks_ = 0;
    }

    // CPU instantiated outside of SetUp to allow for correct
    // program to be assembled and loaded into instruction memory
    void initSimulation()
    {
        top_ = new Vdut(context_);
        tfp_ = new VerilatedVcdC;

        // Initialise trace and simulation
        Verilated::traceEverOn(true);
        top_->trace(tfp_, 99);
        tfp_->open("waveform.vcd");

        // Initialise inputs
        top_->clk = 1;
        top_->rst = 1;
        runSimulation(10);  // Process reset
        top_->rst = 0;
    }

    // Runs the simulation for a clock cycle, evaluates the DUT, dumps waveform.
    void runSimulation(int cycles = 1)
    {
        for (int i = 0; i < cycles; i++)
        {
            for (int clk = 0; clk < 2; clk++)
            {
                top_->eval();
                tfp_->dump(2 * ticks_ + clk);
                top_->clk = !top_->clk;
            }
            ticks_++;

            if (Verilated::gotFinish())
            {
                exit(0);
            }
        }
    }

    void TearDown() override
    {
        // End trace and simulation
        top_->final();
        tfp_->close();

        // Free memory
        if (top_) delete top_;
        if (tfp_) delete tfp_;
        delete context_;
    }

    void compile(const std::string &program)
    {
        // Compile
        system(("./compile.sh " + program).c_str());
    }

protected:
    VerilatedContext* context_;
    Vdut* top_;
    VerilatedVcdC* tfp_;
    unsigned int ticks_;
};
