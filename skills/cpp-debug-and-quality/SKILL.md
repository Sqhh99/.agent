---
name: cpp-debug-and-quality
description: "Use when formatting, linting, or debugging C++."
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ 质量与调试

格式和静态检查以仓库配置文件为准，禁止每次让模型猜风格。

## When to Use

- 加 `.clang-format` / `.clang-tidy`、开 sanitizer、查崩溃/泄漏/数据竞争
- Don't use for: 纯功能实现且质量门已绿

## 仓库应有

- `.clang-format`：全仓统一。改代码后对触及文件跑 format。
- `.clang-tidy`：打开有用的 `bugprone-*`、`modernize-*`（克制）、`cppcoreguidelines-*` 子集。新警告要修，不要全局 `-Wno-`。
- `cmake/Sanitizers.cmake`：Linux/Clang 提供 ASan/UBSan preset。

## Sanitizer

- AddressSanitizer：越界、UAF、double-free。
- UBSan：未定义行为。
- 有数据竞争嫌疑再开 TSan（不要和 ASan 同时开）。
- 默认放到 `linux-clang-asan` CI，不必每个开发机构建都开。

## 调试

- 先复现，再下断点。崩溃要保留可符号化的栈。
- 设备/驱动问题：先确认用户态复现步骤，再下内核。
- 修 bug 走 `cpp-testing-contract` 的回归路径。

## Verification

- [ ] 被改文件通过项目 format
- [ ] 新增公开代码没有被 tidy 必开项打红
- [ ] 内存类 bug 在 ASan 下复现或证明无法复现
