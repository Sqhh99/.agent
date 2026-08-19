---
name: cpp-modern-cpp
description: "Use when writing C++ APIs, ownership, or lifetimes."
version: 2.0.0
author: Sqhh99
license: MIT
---

# 现代 C++ 底座

比「证明符合七大原则」更优先的是资源安全和所有权。面向 C++17/20 工程代码。

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

## 禁止

- new/delete 散落（应用封装进 RAII）
- 把 `shared_ptr` 当默认指针
- 返回指向局部的指针/引用
- 静默忽略 `nodiscard` 错误码

## Verification

- [ ] 每个获取的资源有明确释放点（对象析构）
- [ ] 公开函数的所有权（谁释放、谁保活）能从签名读出
- [ ] 无 owning raw pointer 跨越模块边界
