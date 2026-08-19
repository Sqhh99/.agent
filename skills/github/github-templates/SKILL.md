---
name: github-templates
description: "Use when adding GitHub PR or Issue templates."
version: 1.0.0
author: Sqhh99
license: MIT
---

# GitHub 模板

样本：FLiNG 的 PR / Issue yaml。空白 Issue 关掉，想法先走 Discussions。

## When to Use

- 新开源仓或现有仓还没有 PR/Issue 模板
- Don't use for: 提交信息、分支策略（`git-workflow`）

## 必有

`.github/pull_request_template.md`：关联 Issue、改了什么、怎么验证、AI 披露。

`.github/ISSUE_TEMPLATE/`：

- `config.yml`：`blank_issues_enabled: false`；使用疑问 / 未想清的功能链到 Discussions；安全漏洞走私密 Advisory
- `bug.yml`：版本、系统、实际/期望、复现
- `feature.yml`：要解决的问题，不是先写实现

模板在 `templates/`。按项目改链接和检查项，不要原样贴 FLiNG 的杀毒 FAQ。

## Verification

- [ ] 开 PR 能看到验证清单和 AI 披露
- [ ] 不能再开空白 Issue
