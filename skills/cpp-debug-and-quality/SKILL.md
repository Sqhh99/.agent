---
name: cpp-debug-and-quality
description: "Use when formatting, linting, or debugging C++."
version: 2.1.0
author: Sqhh99
license: MIT
---

# C++ 质量与调试

格式和静态检查以仓库配置文件为准。**禁止风格辩论**——只认本仓 `.clang-format`。

## When to Use

- 加 `.clang-format` / `.clang-tidy`、开 sanitizer、查崩溃/泄漏/数据竞争、合入前评审
- Don't use for: 纯功能实现且质量门已绿

## 仓库应有

- `.clang-format`：全仓唯一风格源。提交前对**触及文件**跑 `clang-format -i`。没有配置就先加一份，不要每次现编规则。
- `.clang-tidy`：`bugprone-*`、克制的 `modernize-*`、`cppcoreguidelines-*` 子集。新警告要修，不要全局 `-Wno-`。
- `cmake/Sanitizers.cmake`：Linux/Clang 提供 ASan/UBSan preset。

## 评审严重度（挡板）

**CRITICAL — 未清不得完成/合入**

- 裸 `new`/`delete`、`malloc`/`free`（未收入 RAII）
- 缓冲区溢出、`strcpy`/`sprintf`、未检查的 C 数组写
- use-after-free、悬空指针/失效迭代器
- 未初始化就读
- 无同步的共享可变数据竞争
- `system()`/`popen()` 吃未校验输入
- 空指针解引用

**HIGH — 同样挡合入**

- Rule of Five 残缺
- 手写 `lock()`/`unlock()`，没有 `lock_guard`/`scoped_lock`
- `std::thread` detach 且寿命不清
- 跨线程对象无 affinity/销毁顺序
- 头文件 `using namespace std;`

**MEDIUM — 记录，不挡**

- 缺 `const`、不必要的大对象拷贝、include 臃肿、函数过长

合入标准：无 CRITICAL/HIGH。MEDIUM 写在 PR 里即可。

## Sanitizer

- ASan：越界、UAF、double-free
- UBSan：未定义行为
- TSan：数据竞争嫌疑时再开（不要和 ASan 同时）
- 默认挂在 `linux-clang-asan` CI，不必每个开发机构建都开

## 调试

- 先复现，再下断点。崩溃保留可符号化的栈。
- 设备/驱动：先确认用户态复现，再下内核。
- 修 bug 走 `cpp-testing-contract` 的回归路径。

## Verification

- [ ] 触及文件已按仓库 `.clang-format` 格式化
- [ ] 无 CRITICAL/HIGH
- [ ] 内存类 bug 在 ASan 下复现或证明无法复现
