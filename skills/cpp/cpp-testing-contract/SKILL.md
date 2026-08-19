---
name: cpp-testing-contract
description: "Use when C++ 测试：场景、回归、分层、Sanitizer。"
version: 2.2.0
author: Sqhh99
license: MIT
---

# C++ 测试契约

不为凑数写测试。默认先实现再测；**修 bug 必须先有会失败的回归测试**。不强制 80% 覆盖，也不对每个功能走 RED-GREEN。

## When to Use

- 新模块、修 bug、加算法、加设备集成、加测试文件、改 CTest
- Don't use for: 纯文案/资源改动

## 目录

```text
tests/unit/          单测
tests/integration/   集成
tests/benchmark/     基准
tests/support/       夹具与假对象（不是用例）
tests/testdata/      录包、黄金数据
```

旧仓若已是 `tests/core` 或 `tests/performance`，新文件仍按上表；搬家另开任务。

## 命名

- **测试源文件必须以 `test_` 开头**：`test_download_manager.cpp`。
- `*_test.cpp`（FLiNG 旧习惯）不要再新增。
- 夹具/support 可以不叫 `test_`，且不得当 CTest 用例注册。

## 框架

- **必须**用测试框架：默认 GoogleTest + CMake/CTest。仓里已声明 Catch2 / doctest 可沿用。
- **禁止**用手写 `main` + `assert` / 打印对比冒充测试。
- 新用例 `gtest_discover_tests()`。骨架：`templates/gtest_example.cpp`、`templates/CMakeLists.gtest.snippet`。

## 路径（按任务类型）

- **默认功能**：场景 → 实现 → 单测 + 有价值的集成测
- **Bug**：复现 → 先写失败的 regression → 修 → 变绿
- **算法**：黄金数据 → 实现 → 数值比较
- **协议**：用例帧 → 编解码 → 往返
- **硬件**：Mock/录包 → 集成 → 有设备再 HITL；无设备标未验证

## 怎么跑

优先：`build.cmd tests` / `./build.sh tests`。  
否则：`cmake --build --preset <name> && ctest --preset <name> --output-on-failure`。

先跑与本次 diff 相关的子集。没实际跑过的测试，不得声称通过。

## 硬规则

- 覆盖真实路径、边界、组合。不会发生的错误不要测。
- 禁止为数量好看而写测试。
- Linux CI 至少一条 ASan（见 `cpp-debug-and-quality`）。
- 不得删测试或改断言迎合错误实现。

## Verification

- [ ] 新测试文件名为 `test_*.cpp`，且在 unit / integration / benchmark 之一
- [ ] 走 GTest（或仓内已声明框架），不是裸 assert
- [ ] bugfix 带回归并有真实 ctest 输出
