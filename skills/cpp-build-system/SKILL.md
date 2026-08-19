---
name: cpp-build-system
description: "Use when editing CMake, presets, or compiler flags."
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ 构建系统（CMake）

现代 CMake：target-based，不用全局污染。人和 CI 都走 preset。

## When to Use

- 新建/改 `CMakeLists.txt`、`CMakePresets.json`、警告、标准、安装导出
- Don't use for: 只改业务 `.cpp` 且构建已通

## 规则

- Target-based：`target_sources`、`target_include_directories`、`target_compile_features`、`target_compile_definitions`、`target_link_libraries`。传播用 `PUBLIC` / `PRIVATE` / `INTERFACE`。
- 禁止新代码使用 `include_directories`、`link_directories`、`add_definitions`。
- C++ 标准用 `target_compile_features(... cxx_std_17)` 或项目统一 `CMAKE_CXX_STANDARD`（选定后不要悄悄升）。
- 警告：`cmake/CompilerWarnings.cmake` 集中开；默认当错误处理新增 warning 需显式讨论。
- 导出 `compile_commands.json`（clangd/tidy）。
- 每个可交付库/可执行文件是独立 target；examples 各自 `add_executable`。
- 安装/导出：库项目提供 `install` + CMake package；应用项目至少能 `cmake --install` 出运行包。

## Presets

仓库应有 `CMakePresets.json`（可提交）。按需提供：

- `windows-msvc-debug` / `windows-msvc-release`
- `linux-gcc-debug` / `linux-gcc-release`
- `linux-clang-asan`（质量门，见 `cpp-debug-and-quality`）

人与 CI 执行：

```text
cmake --preset <name>
cmake --build --preset <name>
ctest --preset <name>
```

不要每次手拼一长串 `-DCMAKE_...`。

## Verification

- [ ] 无新增全局 include/link/define
- [ ] `cmake --preset` 能配置，`cmake --build --preset` 能编过
- [ ] 生成 `compile_commands.json`
