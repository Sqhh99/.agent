---
name: cpp-git-workflow
description: "Use when C++ git：分支 PR、ADR、禁直推 main。"
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ Git 工作流

GitHub PR 保存代码史。不要每个 PR 再抄一份 `docs/note`。

## When to Use

- 建分支、提交、开 PR、合入、打 tag、回顾历史
- Don't use for: 本地一次性实验且用户说不提交

## Commit

- 中英均可。必须有标题 + 正文（改了什么、为什么）。
- 标题前缀：`feat` / `fix` / `refactor` / `docs` / `test` / `chore`。

## 分支

- **禁止直推 main**。分支 → commit → PR → merge。
- 范围保持小；重构单独 PR。

## 记录什么

- **PR**：具体 diff。
- **CHANGELOG**：用户可见变化（有发布时）。
- **ADR**（`docs/adr/`）：对架构、接口、协议、依赖策略、兼容性有长期影响的决策。模板：上下文 / 决策 / 放弃的方案 / 后果。
- **docs/design**：复杂模块设计。

不归档「改了按钮颜色」这种机械笔记。

## Verification

- [ ] 不在 main 上直接提交功能
- [ ] commit 有前缀和说明正文
- [ ] 若改了长期决策，有 ADR，而不是一份流水账 note
