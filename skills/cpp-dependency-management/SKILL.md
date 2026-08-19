---
name: cpp-dependency-management
description: "Use when C++ 第三方依赖：vcpkg、third_party、Fetch 脚本。"
version: 1.0.0
author: Sqhh99
license: MIT
---

# C++ 第三方依赖管理

小徐的 C++ 项目接入第三方库的标准做法。新依赖入库前加载。

## 主路径：vcpkg

- 优先使用 **vcpkg manifest 模式** 管理第三方依赖（`vcpkg.json` 声明，不用 classic 全局模式）。
- vcpkg 与下载的依赖放在项目 `third_party` 目录内，便于项目整体迁移与版本管理。

## 兜底路径：Fetch*.cmake

满足以下任一情况，改用直接拉取构建：

- 目标库不在 vcpkg 仓库；
- vcpkg 编译太久。

做法：

1. 库在 GitHub 有开源仓库 → 直接下载源码构建。
2. 在 `cmake` 目录新增 `Fetch<库名>.cmake`，例如 `FetchONNXRuntime.cmake`、`FetchFFmpeg.cmake`、`FetchWebRTC.cmake`。
3. 下载的源码统一放 `third_party` 目录管理。

## 验收

- [ ] vcpkg 场景：`vcpkg.json` 声明 + 依赖落 `third_party`
- [ ] Fetch 场景：`cmake/Fetch*.cmake` 存在，源码在 `third_party`
- [ ] 新机器 clone 后能按 README 完整复现依赖
