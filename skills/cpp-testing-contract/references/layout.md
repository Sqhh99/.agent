# 测试树

```text
tests/unit/test_*.cpp
tests/integration/test_*.cpp
tests/benchmark/test_*.cpp
tests/support/          # 不注册为用例
tests/testdata/
```

CMake 只对 `test_*.cpp` 做 `gtest_discover_tests`。benchmark 可用 Google Benchmark，文件仍以 `test_` 开头，或单独 target 由 `build.* benchmark` 跑。
