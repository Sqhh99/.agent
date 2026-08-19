---
name: cpp-git-workflow
description: "Use when C++ git：分支 PR、ADR、禁直推 main。"
version: 2.1.0
author: Sqhh99
license: MIT
---

# C++ Git 工作流

GitHub PR 保存代码史。不要每个 PR 再抄一份 `docs/note`。默认 **GitHub Flow**。

## When to Use

- 建分支、提交、开 PR、合入、打 tag、回顾历史
- Don't use for: 本地一次性实验且用户说不提交

## Commit

- 中英均可。必须有标题 + 正文（改了什么、**为什么**）。
- 标题前缀：`feat` / `fix` / `refactor` / `docs` / `test` / `chore` / `ci`。

## 分支

- **禁止直推 main**。`main` 保持可构建。短功能分支 → commit → PR → **merge** 进 main。
- 范围保持小；重构单独 PR。理想一个 PR 只做一件事。
- 分支命名：`feat/...`、`fix/...`、`hotfix/...`。

## Rebase 红线

- **更新尚未推送、只有自己用的本地分支**：可以 `rebase` 到最新 `main`。
- **合入 main**：用 merge（或仓库设定的 merge 按钮），保留分支历史。
- **禁止** rebase 已推送的共享分支、别人已经基于它工作的分支、`main` 本身。
- 必须改写已推送历史时用 `--force-with-lease`，且确认没有其他推送者。

## PR

- 看整段改动：`git diff <base>...HEAD`，不要只看最后一个 commit。
- 描述写 What / Why / How / 怎么测。
- 点「请审」之前：CI 该绿的绿、冲突已解、分支已跟上 base。

## 记录什么

- **PR**：具体 diff。
- **CHANGELOG**：用户可见变化（有发布时）。
- **ADR**（`docs/adr/`）：对架构、接口、协议、依赖策略、兼容性有长期影响的决策。模板见 `cpp-engineering/templates/ADR.md`。
- **docs/design**：复杂模块设计。

不归档「改了按钮颜色」这种机械笔记。

## Verification

- [ ] 不在 main 上直接提交功能
- [ ] commit 有前缀和说明正文
- [ ] PR 基于三点 diff，不是单 commit
- [ ] 未对共享分支做 rebase
- [ ] 若改了长期决策，有 ADR
