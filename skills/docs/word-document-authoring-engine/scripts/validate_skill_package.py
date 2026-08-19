#!/usr/bin/env python3
from __future__ import annotations

import sys
from pathlib import Path

REQUIRED = [
    'SKILL.md', 'README.md', 'CHANGELOG.md', 'manifest.txt',
    'agents/openai.yaml', 'config/defaults.yaml',
    'references/user-preferences.md', 'references/document-structures.md',
    'references/visual-and-layout-rules.md', 'references/evidence-and-boundaries.md',
    'references/quality-gates.md',
    'workflows/01-scope-and-evidence.md', 'workflows/02-research-and-gap-refill.md',
    'workflows/03-outline-and-drafting.md', 'workflows/04-figures-tables-formulas.md',
    'workflows/05-docx-build.md', 'workflows/06-render-repair-deliver.md',
    'templates/project-proposal-outline.md', 'templates/technical-solution-outline.md',
    'templates/research-design-report-outline.md', 'templates/section-writing-unit.md',
    'checklists/content-checklist.md', 'checklists/visual-checklist.md',
    'checklists/final-delivery-checklist.md',
    'scripts/audit_docx_preferences.py', 'examples/example-prompts.md',
]


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else '.').resolve()
    missing = [x for x in REQUIRED if not (root / x).is_file()]
    if missing:
        print('FAIL: missing files:')
        for item in missing:
            print(' -', item)
        return 1

    manifest = [x.strip() for x in (root / 'manifest.txt').read_text(encoding='utf-8').splitlines() if x.strip()]
    actual = sorted(str(p.relative_to(root)).replace('\\', '/') for p in root.rglob('*') if p.is_file() and p.name != 'manifest.txt')
    expected = sorted(x for x in manifest if x != 'manifest.txt')
    if actual != expected:
        print('FAIL: manifest differs from actual files')
        print('Only actual:', sorted(set(actual) - set(expected)))
        print('Only manifest:', sorted(set(expected) - set(actual)))
        return 2

    text = (root / 'SKILL.md').read_text(encoding='utf-8')
    required_phrases = ['图题', '传统方法', '逐页', '工程推断', '表格']
    absent = [p for p in required_phrases if p not in text]
    if absent:
        print('FAIL: SKILL.md missing key rules:', absent)
        return 3

    print('PASS: skill package is complete')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
