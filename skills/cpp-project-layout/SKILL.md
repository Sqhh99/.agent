---
name: cpp-project-layout
description: "Use when C++ 项目结构：core 库、UI 解耦、examples、资源。"
version: 1.0.0
author: Sqhh99
license: MIT
---

# C++ 工程结构规范

小徐的 C++ 项目（含 Qt/上位机/工具类）目录与分层约定。新项目、重构或代码评审时加载。

## 分层架构

- **核心逻辑必须分层**。可复用的公共代码放 `core` 模块，独立编译成动态库或静态库，供上层模块链接。
- **UI 与核心逻辑严格解耦**。除 UI 代码外，UI 相关代码禁止进入核心层。
- 核心层对外只暴露稳定接口；需要公开的接口放到 `include` 目录。

## 可执行程序

- 不同类型/分组的可执行程序，放不同目录，各自维护独立 `CMakeLists.txt`，不要全塞进根 CMake。
- 自定义图表或工具控件，必须在 `examples` 目录放一个**可运行示例程序**，并在对应 `CMakeLists.txt` 单独 `add_executable`。

## 资源

- 图片、图标、音频、视频等资源统一放 `resource/res` 目录，禁止散落在源码目录。

## 验收

- [ ] `core` 可独立编译为库，UI 目录没有 core 的 UI 依赖
- [ ] `include` 只含稳定公开接口
- [ ] 每个自定义控件有 examples 可运行示例
- [ ] 资源都在 `resource/res`
