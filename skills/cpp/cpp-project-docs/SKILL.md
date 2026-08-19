---
name: cpp-project-docs
description: "Use when writing C++ docs: note, fix, feat, perf, refactor."
version: 1.0.0
author: Sqhh99
license: MIT
---

# C++ 项目文档归档

叙事归档和 GitHub PR / ADR 并存。PR 保存 diff；ADR 保存长期决策；本 skill 保存难、大、有效、结构性的故事。

## When to Use

- 刚修完难问题、合入较大功能、做成有效的性能优化、做完架构调整
- Don't use for: 改文案、改按钮颜色、每一次 commit

## 目录

| 目录 | 写什么 |
| --- | --- |
| `docs/note/` | 塞不进下面四类的过程备忘 |
| `docs/fix/` | 难啃的、或多轮交互才修好的问题 |
| `docs/feat/` | 新功能说明 |
| `docs/perf/` | **有成效**的性能优化 |
| `docs/refactor/` | 较大架构或目录调整 |
| `docs/adr/` | 长期决策（见 `cpp-git-workflow`） |

## 命名

`{YYYYMMDDHHmmss}-{标题}.md`

例：`20260819143000-修复DMA对齐崩溃.md`

时区用 Asia/Shanghai。标题用中文或英文均可，不要空格，用短横线。

## 什么时候必须写

- **fix**：卡过一轮以上、或根因不明显
- **feat**：用户可感知的新能力，不是内部小函数
- **perf**：有前后对比（延迟、CPU、拷贝次数），没数就不要进 perf
- **refactor**：模块边界或目录动了
- **note**：值得留下、但不是上面四类

小修复只走 commit/PR，不要刷 `docs/fix`。

## 模板

`templates/note.md` `fix.md` `feat.md` `perf.md` `refactor.md`

## Verification

- [ ] 文件名符合时间戳-标题
- [ ] 落在正确子目录
- [ ] 不是把 PR 正文再贴一遍
