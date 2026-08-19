---
name: git-workflow
description: "Use when git: branches, PRs, ADR, no direct main."
version: 2.3.0
author: Sqhh99
license: MIT
---

# Git 工作流

从 C++ 包迁到 `skills/github/`。GitHub PR 保存代码史。默认 **GitHub Flow**。叙事归档走 `cpp-project-docs`，不要每个 PR 抄一份 note。

## When to Use

- 建分支、提交、开 PR、合入、打 tag、回顾历史
- Don't use for: 本地一次性实验且用户说不提交

## Commit

- 中英均可。必须有标题 + 正文（改了什么、**为什么**）。
- 标题前缀：`feat` / `fix` / `refactor` / `docs` / `test` / `chore` / `ci`。

## 分支

- **禁止直推 main**。短功能分支 → commit → PR → **merge** 进 main。
- 范围保持小；重构单独 PR。
- 分支命名：`feat/...`、`fix/...`、`hotfix/...`。

## Rebase 红线

- 仅尚未推送、只有自己用的本地分支可以 rebase 到 `main`。
- 合入 main 用 merge。禁止 rebase 共享分支或 `main`。
- 必须改写已推送历史时用 `--force-with-lease`。

## PR

- 看整段：`git diff <base>...HEAD`。
- 描述 What / Why / How / 怎么测。模板见 `github-templates`。CI 绿、冲突已解再请审。
- 他人开源仓还要遵守 `github-oss-guard`。

## 记录什么

- **PR**：具体 diff。
- **CHANGELOG**：用户可见变化（有发布时）。
- **ADR**（`docs/adr/`）：长期决策。模板：`skills/cpp/cpp-engineering/templates/ADR.md`。
- **叙事**：`docs/note|fix|feat|perf|refactor`，规则与命名见 `cpp-project-docs`。两类并存。

## Verification

- [ ] 不在 main 上直接提交功能
- [ ] commit 有前缀和说明正文
- [ ] PR 基于三点 diff
- [ ] 未对共享分支 rebase
- [ ] 长期决策有 ADR；难/大/有效/结构性故事进对应 docs 子目录
