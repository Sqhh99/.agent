---
name: cpp-design-and-comments
description: "Use when C++ 设计/注释：契约、意图、非显然约束。"
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ 设计与注释

七大原则是导向，不是每个类的打卡表。注释写「为什么」和契约，不写「这行在干什么」。

## When to Use

- 设计新类型、写公开头、评审注释噪音或缺失
- Don't use for: 纯构建脚本

## 设计导向

单一职责、开闭、依赖抽象、接口隔离、可替换、最少知识、优先组合。

用来做设计决策，不要在 PR 里要求「证明本类符合全部七条」。更基础的规则在 `cpp-modern-cpp`。

## 注释

**公开 API（`.h`）**：Doxygen 写契约——输入/输出、单位、所有权、线程安全、错误语义、前/后置条件。名字已经说完的 `setName` 不要再写「设置名字」。

**私有 API**：只有非显然契约才写 Doxygen。

**`.cpp`：允许且应当**解释设计意图、算法依据、数值假设、并发/线程亲和、资源寿命、硬件限制、协议限制、workaround、非显然性能取舍。

例如：

```cpp
// FPGA DMA requires 4096-byte aligned buffers.
// Do not replace this allocation with std::vector directly.
```

**禁止**：复述代码、过期注释、流水账。不是「禁止 cpp 注释」。

## Verification

- [ ] 公开头能读出契约，没有废话注释
- [ ] 非显然的硬件/协议/并发约束在代码旁有「为什么」
- [ ] 没有为原则打卡而加的空文档
