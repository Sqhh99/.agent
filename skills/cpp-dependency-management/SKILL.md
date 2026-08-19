---
name: cpp-dependency-management
description: "Use when C++ 第三方依赖：stdlib、vcpkg、SDK、Fetch。"
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ 第三方依赖

「vcpkg 太慢就改 Fetch」不成立。FetchContent 同样要编译。先决策树，再选工具。

## When to Use

- 加库、换版本、引入官方 SDK、整理 third_party
- Don't use for: 只用标准库就能解决的改动

## 决策树（从上到下）

1. 项目里是否已有同一能力？复用。
2. 标准库能否解决？用标准库。
3. vcpkg 有端口且版本可接受 → **manifest 模式**（`vcpkg.json` + baseline）。
4. 官方 CMake package / 预编译 SDK（CUDA、厂商驱动、Qt 官方包）。
5. FetchContent / `cmake/Fetch<Name>.cmake`：无端口、或必须跟特定 commit。
6. vendored `third_party/vendored/`：离线、补丁、或上游不适合包管理。

## 目录

- 不要把「vcpkg 工具」和「安装结果」都叫 third_party。
- 建议：`third_party/vendored/` 只放源码供应商库；`build/vcpkg_installed/` 不进 git。
- vcpkg 本身：submodule、bootstrap、或 CI 预装，由项目 README 写死一种。

## Manifest 要真用

- `builtin-baseline`、版本约束、必要时 `overrides`。
- triplet、overlay ports、binary cache 写进 README/CI，避免每人编译两小时。
- 记录许可证与 ABI 约束。升级依赖是显式 PR，不是顺手。

## Verification

- [ ] 能指出走了决策树的哪一层，以及为什么不是上一层
- [ ] 新机器按 README 能复现依赖
- [ ] 未把编译产物提交进 git
