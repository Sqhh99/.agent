---
name: github-actions
description: "Use when adding GitHub Actions build or release."
version: 1.0.0
author: Sqhh99
license: MIT
---

# GitHub Actions

样本：FLiNG `build.yml` + `make-release.yml`，links 的 OS matrix。C++ 要测什么见 `cpp-ci-release`。本 skill 只管 workflow 怎么写。

## When to Use

- 新仓搭 Actions、改 matrix、做 tag 发布
- Don't use for: 本地 `build.cmd` 本身（`cpp-build-system`）

## 分工

| 文件 | 触发 | 做什么 |
| --- | --- | --- |
| `.github/workflows/build.yml` | `pull_request` + `push` 到 main | 配置、编、测、上传 artifact |
| `.github/workflows/release.yml` | `v*` tag | Release 构建、打包、checksum、GitHub Release |

不要把发版步骤塞进 PR workflow。

## 规则

- 默认 `permissions: contents: read`。只有发版 job 再开 `contents: write`。
- 入口是仓里的 `build.cmd` / `build.sh`，不要在 YAML 里再写一长串 cmake。
- Qt 用 `jurplel/install-qt-action`，版本钉死（links 用 6.8.3；FLiNG 钉过 6.9.0）。
- 多 OS 用 **一个** workflow 的 `strategy.matrix`，`fail-fast: false`。
- 只编过 ≠ 测过。PR 必须跑 `tests`。
- 不默认三端；项目只要 Windows 就只跑 Windows。
- checkout `v4`；需要 submodule 再 `submodules: recursive`。

模板：`templates/build.yml`、`templates/release.yml`。

## Verification

- [ ] PR 红能拦住编不过 / 测不过
- [ ] 打 `vX.Y.Z` 能出 Release
- [ ] 最小权限，发版才 write
