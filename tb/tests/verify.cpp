#include <cstdlib>
#include <utility>

#include "cpu_testbench.h"

#define CYCLES 10000

TEST_F(CpuTestbench, TestAddiBne)
{
    setupTest("1_addi_bne");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 254);
}

TEST_F(CpuTestbench, TestLiAdd)
{
    setupTest("2_li_add");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 1000);
}

TEST_F(CpuTestbench, TestLbuSb)
{
    setupTest("3_lbu_sb");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 300);
}

TEST_F(CpuTestbench, TestJalRet)
{
    setupTest("4_jal_ret");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 53);
}

TEST_F(CpuTestbench, TestPdf)
{
    setupTest("5_pdf");
    setData("reference/gaussian.mem");
    initSimulation();
    runSimulation(CYCLES * 100);
    EXPECT_EQ(top_->a0, 15363);
}

TEST_F(CpuTestbench, TestCacheHit)
{
    setupTest("8_cache_hit");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 126);
}

TEST_F(CpuTestbench, TestCacheMissSetConflict)
{
    setupTest("9_cache_miss_set_conflict");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 300);
}

TEST_F(CpuTestbench, TestMemoryOffsets)
{
    setupTest("10_memory_offsets");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 100);
}

TEST_F(CpuTestbench, TestBitwise)
{
    setupTest("11_bitwise");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 28);
}

TEST_F(CpuTestbench, TestShifts)
{
    setupTest("12_shifts");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 200);
}

TEST_F(CpuTestbench, TestStoreHalfwords)
{
    setupTest("13_store_halfwords");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 300);
}

TEST_F(CpuTestbench, TestBranches)
{
    setupTest("14_branches");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 6);
}

TEST_F(CpuTestbench, TestComparisons)
{
    setupTest("15_comparisons");
    initSimulation();
    runSimulation(CYCLES);
    EXPECT_EQ(top_->a0, 2);
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();
    return res;
}
