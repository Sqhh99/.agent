---
name: github-oss-guard
description: "Use when contributing to others' GitHub repos."
version: 1.0.0
author: Sqhh99
license: MIT
---

# 他人开源仓红线

来源：llama.cpp `AGENTS.md`。**只约束给别人的仓提贡献。** Sqhh99 自己的仓可以按 `git-workflow` 正常开 PR、写描述。

## When to Use

- 在 llama.cpp、dsh、pi 等他人仓改代码、准备 PR
- Don't use for: `Sqhh99/*` 和本机 `.agent`

## 禁止（他人仓）

- 不代跑 `gh pr create` / `gh pr comment` / `gh issue comment`
- 不代写 PR 描述、commit message（除非用户逐条审过并明确说「代我提交」）
- 不代回 reviewer
- 不 `git push` 到用户的 fork/PR，除非用户当面确认

## 必须

- 改之前读对方 `AGENTS.md` / `CONTRIBUTING.md`
- PR 里按对方模板做 **AI 披露**
- 用户要能独立向 reviewer 讲清每一处改动

## Verification

- [ ] 确认这是不是自己的仓
- [ ] 他人仓：没有代开 PR、代评、代推
