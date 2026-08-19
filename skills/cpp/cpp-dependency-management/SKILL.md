---
name: cpp-dependency-management
description: "Use when C++ 第三方依赖：stdlib、vcpkg、SDK、Fetch。"
version: 2.3.0
author: Sqhh99
license: MIT
---

# C++ 第三方依赖

vcpkg 管「源码端口、本地编出来」。`cmake/Fetch*.cmake` 管「官方/厂商已经编好的二进制 Release」。两者不要做成同一件事。

黄金样本：`FLiNG-Downloader/cmake/FetchONNXRuntime.cmake`、`links/cmake/FetchLiveKitSDK.cmake`、`webrtc-peerconnection-client/cmake/FetchFFmpeg.cmake`。

## When to Use

- 加库、换版本、写 Fetch 脚本、整理 third_party
- Don't use for: 只用标准库就能解决的改动

## 决策树

1. 仓内是否已有同一能力？复用。
2. 标准库能否解决？用标准库。
3. 普通开源库、vcpkg 有端口且版本可接受 → **vcpkg manifest**。
4. 体积大、编译极重、或上游只发预编译包（ONNX Runtime、LiveKit SDK、FFmpeg 构建、厂商 SDK）→ **`cmake/Fetch<Name>.cmake` 拉 Release 二进制**。
5. 官方安装器 / 系统包（Qt、CUDA、驱动）→ 文档写清路径，`CMAKE_PREFIX_PATH` 注入，不要写死盘符进 CMake。
6. 必须改上游源码或离线补丁 → `third_party/vendored/`。

**禁止**用 `FetchContent` / Fetch 脚本去克隆源码再在本机构建——那是 vcpkg 的活，而且更慢、更难复现。

## Fetch*.cmake 契约

脚本只做四件事：

1. 钉死 **版本 + 平台 + 架构**（win/linux/mac × x64/arm64）。
2. `file(DOWNLOAD)` 上游 **GitHub Releases / 官方 SDK 包**（zip/tgz），可选 `EXPECTED_HASH`。
3. 解压到 `third_party/<name>-<platform>-<arch>-<ver>/`，找到 `include/` + `lib/`（及 Windows 的 dll）。
4. 导出 include/lib/runtime 路径，或 `IMPORTED` / `INTERFACE` target。已存在则跳过下载。

模板：`templates/FetchPrebuilt.cmake`。细则：`references/fetch-prebuilt.md`。

## 目录

- `third_party/vcpkg`：工具（若采用仓内 bootstrap）
- `build/vcpkg_installed/`：vcpkg 安装结果，不进 git
- `third_party/<sdk-pkg>/`：Fetch 下来的预编译 SDK（体积大可 gitignore，靠脚本再现）
- `third_party/vendored/`：必须改的源码

## vcpkg

manifest + `builtin-baseline` + 版本约束。triplet / binary cache 写进 README/CI。

## Verification

- [ ] 能指出走了决策树哪一层
- [ ] 新的 Fetch 脚本下载的是预编译包，不是源码树
- [ ] 干净机器按 README / `build.*` 能再现依赖
