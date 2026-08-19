# Word Document Authoring Engine

这是一个面向正式 Word 技术文档的可复用 Skill，适合项目建议书、工程解决方案、研究型设计报告、国产化替代方案和军民融合方案。

它固化了以下长期偏好：

- 先写需求与现有问题，再写传统方法及局限；
- 方案必须落到设备、算法、数据、平台、实施和验证；
- 研究型内容需要论文、标准或权威资料支撑；
- 表格少而必要，图示承担架构、流程和部署解释；
- 图内不放主标题，图题位于图片下方；
- 图形配色克制，优先黑灰或深蓝辅助色；
- 生成 DOCX 后必须逐页渲染检查并循环修复；
- 文件名正式，不交付过程垃圾文件。

## 目录

```text
word-document-authoring-skill/
├── SKILL.md
├── README.md
├── CHANGELOG.md
├── manifest.txt
├── agents/
│   └── openai.yaml
├── config/
│   └── defaults.yaml
├── references/
│   ├── user-preferences.md
│   ├── document-structures.md
│   ├── visual-and-layout-rules.md
│   ├── evidence-and-boundaries.md
│   └── quality-gates.md
├── workflows/
│   ├── 01-scope-and-evidence.md
│   ├── 02-research-and-gap-refill.md
│   ├── 03-outline-and-drafting.md
│   ├── 04-figures-tables-formulas.md
│   ├── 05-docx-build.md
│   └── 06-render-repair-deliver.md
├── templates/
│   ├── project-proposal-outline.md
│   ├── technical-solution-outline.md
│   ├── research-design-report-outline.md
│   └── section-writing-unit.md
├── checklists/
│   ├── content-checklist.md
│   ├── visual-checklist.md
│   └── final-delivery-checklist.md
├── scripts/
│   ├── validate_skill_package.py
│   └── audit_docx_preferences.py
└── examples/
    └── example-prompts.md
```

## 最简使用方式

> 使用 Word Document Authoring Engine，围绕无人船四季水文调查和环境动态监测编写项目建议书。先写需求与传统方法，再提出系统方案、设备配置、算法原理、实施路线和验收指标。表格不要多，配架构图和作业流程图，图题放在图下，最终输出 DOCX。

## 校验

```bash
python scripts/validate_skill_package.py .
python scripts/audit_docx_preferences.py 成品.docx
```
