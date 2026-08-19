---
name: cpp-engineering
description: "Use when starting any C++ coding or review task."
version: 2.1.0
author: Sqhh99
license: MIT
---

# C++ 工程总控

接到 C++ 任务时先走这里。本 skill 管工作流和完成定义，不管具体语法。仓库里已有的规范优先于本套默认值。

## When to Use

- 新功能、修 bug、重构、加模块、加依赖、加测试、做评审
- 用户说「按我的 C++ 规范做」
- Don't use for: 纯文档翻译、与本仓无关的脚本

配套：`cpp-project-layout`、`cpp-build-system`、`cpp-dependency-management`、`cpp-modern-cpp`、`cpp-design-and-comments`、`cpp-testing-contract`、`cpp-debug-and-quality`、`cpp-git-workflow`、`cpp-ci-release`；Qt 上位机再加 `cpp-qt-application`；设备/协议再加 `cpp-device-io`。

## Procedure

0. **先搜再写**：本仓已有模块、已有依赖、公开头。新能力先复用；不要先加库或从零造。完成：能指出复用点或写明「仓内没有等价物」。
1. **读现有工程**：README、根 `CMakeLists.txt`、`CMakePresets.json`、`vcpkg.json`、`.clang-format`、目录和代码风格。完成：能说出项目类型与构建入口。
2. **判定画像**：Library / CLI / Qt GUI / Device / Algorithm / SDK；OS、编译器、C++ 标准、Qt、CMake、依赖管理器、测试框架。完成：画像写进回复。
3. **定范围**：现有规范优先。用户没要求重构就禁止扩大 diff。不改 `generated/`、`vendor/`、`third_party/` 源码。
4. **计划（复杂任务才写，不要另开五份文档）**：分可独立合并的阶段。每步必须有：
   - 文件路径
   - 为什么
   - 依赖哪一步
   - 风险 Low/Med/High
   - 本步怎么验收
5. **设计接口再实现**：公开 API 先定契约（所有权、错误、线程、单位），再写代码。
6. **落地后必须真跑**：configure → build → 相关测试 → 静态检查/format → 看 diff。完成：每步有真实命令输出。
7. **评审挡板**：按 `cpp-debug-and-quality` 的严重度扫一遍触及的 C++。有 CRITICAL/HIGH 不得宣称完成、不得合入。
8. **收尾**：按 `cpp-git-workflow` 分支/提交；需要发布再走 `cpp-ci-release`。

## Verification Contract

- 没跑编译，不得写「编译通过」。
- 没跑测试，不得写「测试通过」。
- 没有硬件，不得写「硬件验证完成」。
- 命令失败不得绕过并宣称完成。
- 不得为让测试变绿而删有效测试或改测试迎合错误实现。
- 不得静默关 warning；不得 `catch (...)` 吞未知异常。
- 不得用空实现、TODO、假 mock 结果冒充做完。
- 因硬件/SDK/驱动无法验证的项，必须单独列出「未验证」。
- 存在 CRITICAL/HIGH 评审项，任务未完成。

## Pitfalls

- 只加载了测试或布局 skill、跳过本流程，会漏编译和范围控制。
- 把「七大原则」或「必须有 core/」当成比现有仓结构更高的权威。
- 为计划而写 PRD/architecture 长文；步骤里写清路径即可。
