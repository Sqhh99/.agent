---
name: cpp-ci-release
description: "Use when C++ CI：format、build、test、tag 发布。"
version: 2.1.0
author: Sqhh99
license: MIT
---

# C++ CI 门禁

YAML 怎么写、权限、matrix、tag 发版见 `github-actions`。这里只定 **C++ 仓必须跑什么**。

## When to Use

- 给 C++ 仓定 PR 检查顺序、sanitizer、发布物内容
- Don't use for: 纯写 Actions 语法（用 `github-actions`）

## PR 必须过

format → 静态检查（仓里已有才跑）→ configure → build → unit → 有价值的 integration → Linux/Clang 至少一条 sanitizer（项目声称支持时）

入口仍是 `build.cmd tests` / `build.sh tests`。编过 ≠ 测过 ≠ 可发布。

## Release 必须有

`vX.Y.Z` tag → Release 构建 → 按项目打包（不盲目三端）→ checksum → changelog。不默认伪造签名。

包名带项目、版本、平台、构建类型。Debug 包不要当正式 Release。

## Verification

- [ ] PR 能拦住格式/编译/测试失败
- [ ] 没把「只编过」写成「测过」
- [ ] workflow 文件符合 `github-actions`
