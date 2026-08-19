---
name: cpp-git-workflow
description: "Use when C++ git：前缀 commit、分支 PR、禁直推 main。"
version: 1.0.0
author: Sqhh99
license: MIT
---

# C++ 项目 git 规范

小徐的 C++ 项目版本管理约定。提交、合入、归档都按这套来。

## Commit 规范

- 信息用中文或英文均可；**必须包含标题 + 变更描述**，不能只写一行标题。
- 标题必须带标准前缀：`feat`、`fix`、`refactor` 等（conventional commits 风格）。

## 分支与合入

- 代码改动后**不允许直接提交 main**。
- 正确流程：新建分支 → 提交 commit → 通过 **PR merge 进 main**。

## PR 归档

- 每个 PR 完成后，在 `docs/note` 目录归档记录。
- 命名格式：`{年}{月}{日}{时}{分}{秒}-{标题}.md`，例如 `20260819120001-添加图表控件.md`。
- 归档原则：**不删除**，留作历史。

## 验收

- [ ] commit 标题带 `feat:/fix:/refactor:` 前缀，且有描述体
- [ ] 无直推 main 的记录
- [ ] 每个 PR 在 `docs/note/` 有归档文件
