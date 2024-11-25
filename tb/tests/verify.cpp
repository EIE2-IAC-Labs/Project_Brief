#include "cpu_testbench.h"
#include <cstdlib>
#include <iostream>

#define CYCLES 10000

TEST_F(CpuTestbench, BaseProgramTest)
{
    bool success = false;
    compile("asm/program.S");
    initSimulation();

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
        if (top_->a0 == 254)
        {
            SUCCEED();
            success = true;
            break;
        }
    }
    if (!success)
    {
        FAIL() << "Counter did not reach 254";
    }
}

TEST_F(CpuTestbench, Return5Test)
{
    compile("c/return_5.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 5);
}

TEST_F(CpuTestbench, TestAdd)
{
    compile("c/01-add.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 246);
}

TEST_F(CpuTestbench, TestSub)
{
    compile("c/02-sub.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 889);
}

TEST_F(CpuTestbench, TestXor)
{
    compile("c/03-xor.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 7942);
}

TEST_F(CpuTestbench, TestOr)
{
    compile("c/04-or.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 8191);
}

TEST_F(CpuTestbench, TestSll)
{
    compile("c/05-sll.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 74496);
}

TEST_F(CpuTestbench, TestSrl)
{
    compile("c/06-srl.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 4658);
}

TEST_F(CpuTestbench, TestSra)
{
    compile("c/07-sra.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, -1250);
}

TEST_F(CpuTestbench, TestSlt)
{
    compile("c/08-slt.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 1);
}

TEST_F(CpuTestbench, TestSltu)
{
    compile("c/09-sltu.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 2);
}

TEST_F(CpuTestbench, TestLui)
{
    compile("c/10-lui.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 17257);
}

TEST_F(CpuTestbench, TestBeq)
{
    compile("c/11-beq.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 1);
}

TEST_F(CpuTestbench, TestBne)
{
    compile("c/12-bne.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 50);
}

TEST_F(CpuTestbench, TestBlt)
{
    compile("c/13-blt.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 273);
}

TEST_F(CpuTestbench, TestBge)
{
    compile("c/14-bge.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 300);
}

TEST_F(CpuTestbench, TestBltu)
{
    compile("c/15-bltu.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 0);
}

TEST_F(CpuTestbench, TestBgeu)
{
    compile("c/16-bgeu.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ((int)top_->a0, -50);
}

TEST_F(CpuTestbench, TestJalr)
{
    compile("c/17-jalr.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 2048);
}

TEST_F(CpuTestbench, TestLoadStore)
{
    compile("c/18-lbsb.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 255);
}

TEST_F(CpuTestbench, TestFor)
{
    compile("c/19-for.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 5050);
}

TEST_F(CpuTestbench, TestFibonacci)
{
    compile("c/20-fibonacci.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 55);
}

TEST_F(CpuTestbench, TestLinkedList)
{
    compile("c/21-linked_list.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 158);
}

TEST_F(CpuTestbench, TestPtr)
{
    compile("c/22-ptr.c");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 17);
}

TEST_F(CpuTestbench, TestPdf)
{
    compile("c/23-pdf.c");
    initSimulation();
    runSimulation(CYCLES * 5);
    EXPECT_EQ(top_->a0, 4096);
}

// This will never pass unless you can find a way to get rid of the jump table
// or implement it in the CPU and get the compiler to put it in the right place
// Bonus marks if you get this passing.

// TEST_F(CpuTestbench, TestCase)
// {
//     system("./compile.sh c/24-case.c");
//     initSimulation();
//     runSimulation(CYCLES);
//     EXPECT_EQ(top_->a0, 5);
// }

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();
    return res;
}
