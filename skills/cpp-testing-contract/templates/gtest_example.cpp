// tests/unit/test_add.cpp
#include <gtest/gtest.h>

int Add(int a, int b);

TEST(AddTest, AddsTwoNumbers) {
    EXPECT_EQ(Add(2, 3), 5);
}

TEST(AddTest, HandlesZero) {
    EXPECT_EQ(Add(0, 4), 4);
}
