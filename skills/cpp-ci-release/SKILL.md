---
name: cpp-ci-release
description: "Use when C++ CI：build.yml PR 触发、release.yml tag 触发。"
version: 1.0.0
author: Sqhh99
license: MIT
---

# C++ 项目 CI/CD 规范

新开 C++ 项目必须配套的 GitHub Actions 工作流。

## 最少要求

新项目至少有两个 workflow：

### build.yml

- **触发条件**：PR 提交或代码合入（`pull_request` + `push` 到 main）。
- 内容：检出 → 配置 CMake → 构建 → 跑测试。

### release.yml

- **触发条件**：提交 **tag**（`push: tags`）。
- 内容：自动构建 → 打包 → 发布到 GitHub Releases。
- 打包平台（Windows / macOS / Linux）按项目实际需求取舍，不盲目三平台全开。

## 验收

- [ ] `.github/workflows/build.yml` 存在，PR/merge 触发
- [ ] `.github/workflows/release.yml` 存在，tag 触发
- [ ] 打 tag 后能产出 release 包
