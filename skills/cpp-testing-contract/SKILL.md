---
name: cpp-testing-contract
description: "Use when C++ 测试：场景、回归、分层、Sanitizer。"
version: 2.1.0
author: Sqhh99
license: MIT
---

# C++ 测试契约

不为凑数写测试。默认先实现再测；**修 bug 必须先有会失败的回归测试**。不强制 80% 覆盖，也不对每个功能走 RED-GREEN。

## When to Use

- 新模块、修 bug、加算法、加设备集成、看覆盖是否有用
- Don't use for: 纯文案/资源改动

## 路径（按任务类型）

- **默认功能**：场景/需求 → 实现 → 单测+有价值的集成测
- **Bug**：复现 → 先写失败的 regression → 修 → 变绿
- **算法**：参考/黄金数据 → 实现 → 数值比较
- **协议**：用例帧 → 编解码 → 往返测试
- **硬件**：Mock/录包 → 集成 → 有设备再 HITL；无设备标未验证

## 层级（按项目选，不是每项全上）

Unit / Component / Integration / System / Regression / Benchmark / Hardware-in-the-loop

目录习惯：`tests/unit`、`tests/integration`、`tests/testdata`（或项目已有布局）。

## 怎么跑

默认 GoogleTest + CMake/CTest。新测试用 `gtest_discover_tests()`。骨架见 `templates/gtest_example.cpp` 与 `templates/CMakeLists.gtest.snippet`。

```text
cmake --preset <name>
cmake --build --preset <name>
ctest --preset <name> --output-on-failure
```

没有 preset 时：`cmake --build build && ctest --test-dir build --output-on-failure`。

先跑与本次 diff 相关的子集，再视需要跑全套。没实际跑过的测试，不得声称通过。

## 硬规则

- 覆盖**真实会走的路径、边界、组合**。不会发生的错误不要测。
- 禁止为数量好看而写测试。
- Linux CI 至少一条 ASan（或项目等价）门；见 `cpp-debug-and-quality`。
- 不得删测试或改断言来迎合错误实现。
- 优先注入/假对象隔离；少用改不动的全局单例。

## Verification

- [ ] 新功能有对应真实场景测试，或写明为何本层不测
- [ ] bugfix 带回归测试且本地/CI 跑过（有命令输出）
- [ ] 无凑数用例
