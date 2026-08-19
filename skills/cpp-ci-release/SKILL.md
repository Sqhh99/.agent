---
name: cpp-ci-release
description: "Use when C++ CI：format、build、test、tag 发布。"
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ CI 与发布

PR CI ≠ Release CI。编译成功 ≠ 测试成功 ≠ 可发布。

## When to Use

- 新仓库搭 Actions、改 matrix、做 tag 发布
- Don't use for: 与构建发布无关的业务代码

## PR（`build.yml`）

触发：`pull_request` 与 `push` 到 main。建议流水线：

format → 静态检查（能自动化的）→ configure → build → unit → 有价值的 integration → 至少一条 sanitizer（Linux/Clang）

用 GitHub Actions **matrix** 铺 OS/编译器，不要复制多份 workflow。产物用 artifact 传递。

## Release（`release.yml`）

触发：`vX.Y.Z` tag（SemVer）。流水线：

Release 构建 → 按项目打包（Win/Linux/mac，按需，不盲目三端）→ symbols → checksum → changelog → GitHub Release。需要签名再加，不默认伪造。

## 命名

- tag：`v1.2.3`
- 包名带项目、版本、平台、构建类型
- Debug 包不要当正式 Release 传

## Verification

- [ ] PR 能拦住格式/编译/测试失败
- [ ] 打 tag 能产出带 checksum 的 Release
- [ ] 没有把「只编过」写成「测过」
