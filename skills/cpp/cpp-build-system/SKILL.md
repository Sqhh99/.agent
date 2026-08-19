---
name: cpp-build-system
description: "Use when editing CMake, presets, or compiler flags."
version: 2.2.0
author: Sqhh99
license: MIT
---

# C++ 构建系统

人的入口是 `build.cmd` / `build.sh`。CMake 保持 target-based。跨平台脚本按项目需要给，命令名两边对齐。

## When to Use

- 新建/改 CMake、presets、vcpkg、CI 构建、仓库根部 build 脚本
- Don't use for: 只改业务 `.cpp` 且构建已通

## 入口脚本

- Windows 项目必须有 `build.cmd`。还要 Linux/mac 再给 `build.sh`，**命令名相同**。
- 只做 Windows 就不要假装有 `.sh`。
- Debug / Release 分目录，例如 `build/debug` 与 `build/release`（或 `build/ninja-debug`），禁止混编互踩。
- 黄金样本：`FLiNG-Downloader/build.cmd`。模板：`templates/build.cmd`、`templates/build.sh`。
- 命令矩阵见 `references/build-command-matrix.md`。至少实现：`debug` `release` `tests` `configure` `rebuild` `clean`。有基准再加 `benchmark`；应用可加 `run`。

## CMake

- Target-based：`target_sources` / `target_include_directories` / `target_compile_features` / `target_compile_definitions` / `target_link_libraries`。`PUBLIC` / `PRIVATE` / `INTERFACE`。
- 禁止新代码 `include_directories`、`link_directories`、`add_definitions`。
- 标准用 `target_compile_features(... cxx_std_17)` 或统一 `CMAKE_CXX_STANDARD`，选定后不要悄悄升。
- 警告集中在 `cmake/CompilerWarnings.cmake`；导出 `compile_commands.json`。
- 仓库提交 `CMakePresets.json`。人与 CI：`cmake --preset` → `cmake --build --preset` → `ctest --preset`。脚本内部可以调 preset。

## 依赖与兜底

1. `vcpkg.json` manifest（`templates/vcpkg.json`）
2. 大包/预编译 SDK：`cmake/Fetch<Name>.cmake` **只下载 Release 二进制**（见 `cpp-dependency-management`），禁止 FetchContent 编源码
3. CI workflow 在干净机器上跑同一套 `build.cmd tests` / `build.sh tests`

细节见 `cpp-dependency-management`。

## Verification

- [ ] 有与平台匹配的 build 脚本，debug/release 目录分离
- [ ] `build.* tests` 能配置、编译并跑测试（有真实输出）
- [ ] 无新增全局 include/link/define
