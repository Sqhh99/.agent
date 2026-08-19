---
name: cpp-modern-cpp
description: "Use when writing C++ APIs, ownership, or lifetimes."
version: 2.1.0
author: Sqhh99
license: MIT
---

# 现代 C++ 底座

比「证明符合七大原则」更优先的是资源安全和所有权。面向 C++17/20 工程代码。更深的编号规则见 `references/core-guidelines-digest.md`（按需读，不要每轮整篇加载）。

## When to Use

- 写新类、公开 API、缓冲区、智能指针、错误策略
- 评审生命周期、ABI、线程安全
- Don't use for: 纯 CMake/CI 改动

## 默认规则

- **RAII**：每个资源（内存、句柄、锁、文件、映射）有对象析构释放。
- **Rule of Zero 优先**；必须自定义五特殊成员时，五者一起考虑或 `= delete`。
- **所有权写进类型**：`std::unique_ptr` 独占，`shared_ptr` 仅共享生命周期时用。禁止 owning raw pointer 出函数。
- 非拥有视图用 `std::span` / `std::string_view`；调用方保证对象活过调用。
- **const correctness**；`enum class`；避免 C 数组和宏常量。
- 值语义优先；需要多态再用接口 + 虚函数或 type erasure。
- `noexcept` 只标真正不会抛的；移动操作尽量 `noexcept`。
- 公开头文件保持 ABI/API 稳定：不在公开头里暴露可变布局，除非 major 版本允许。

## 安全黑名单

- 禁止 `strcpy` / `strcat` / `sprintf` / `gets`；用 `std::string` 或有界 API。
- 禁止散落 `malloc`/`free` 和裸 `new`/`delete`。
- 禁止默认依赖编译器 padding 的协议结构体；需要打包时显式写，并配测试。
- `reinterpret_cast` 仅用于已文档化的设备/协议边界，并说明对齐。
- 不要把 packed 线缓冲直接当本地对象用。
- 整数来自不可信输入时检查溢出/截断。

## 禁止（风格）

- 把 `shared_ptr` 当默认指针
- 返回指向局部的指针/引用
- 静默忽略 `nodiscard` 错误码
- 头文件 `using namespace std;`

## Verification

- [ ] 每个获取的资源有明确释放点（对象析构）
- [ ] 公开函数的所有权能从签名读出
- [ ] 无 owning raw pointer 跨越模块边界
- [ ] 无黑名单中的 C 字符串/分配 API
