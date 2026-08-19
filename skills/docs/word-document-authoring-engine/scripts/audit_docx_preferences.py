#!/usr/bin/env python3
from __future__ import annotations

import json
import re
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

W = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'
A = 'http://schemas.openxmlformats.org/drawingml/2006/main'
V = 'urn:schemas-microsoft-com:vml'
NS = {'w': W, 'a': A, 'v': V}


def p_text(p: ET.Element) -> str:
    return ''.join((t.text or '') for t in p.findall('.//w:t', NS)).strip()


def has_image(p: ET.Element) -> bool:
    return bool(p.findall('.//w:drawing', NS) or p.findall('.//w:pict', NS))


def style_id(p: ET.Element) -> str:
    node = p.find('./w:pPr/w:pStyle', NS)
    return node.get(f'{{{W}}}val', '') if node is not None else ''


def audit(path: Path) -> dict:
    report = {'file': path.name, 'errors': [], 'warnings': [], 'metrics': {}}
    if not path.is_file():
        report['errors'].append('file_not_found')
        return report
    if not zipfile.is_zipfile(path):
        report['errors'].append('not_a_valid_docx_zip')
        return report

    with zipfile.ZipFile(path) as zf:
        names = set(zf.namelist())
        if 'word/document.xml' not in names:
            report['errors'].append('missing_document_xml')
            return report
        root = ET.fromstring(zf.read('word/document.xml'))

    body = root.find('w:body', NS)
    blocks = list(body) if body is not None else []
    paras = [b for b in blocks if b.tag == f'{{{W}}}p']
    tables = [b for b in blocks if b.tag == f'{{{W}}}tbl']
    image_indices = [i for i, b in enumerate(blocks) if b.tag == f'{{{W}}}p' and has_image(b)]
    captions = [(i, p_text(b)) for i, b in enumerate(blocks)
                if b.tag == f'{{{W}}}p' and re.match(r'^图\s*[0-9一二三四五六七八九十]+', p_text(b))]
    headings = [p for p in paras if style_id(p).lower().startswith('heading')]

    report['metrics'].update({
        'paragraphs': len(paras),
        'tables': len(tables),
        'images': len(image_indices),
        'figure_captions': len(captions),
        'headings': len(headings),
    })

    if len(tables) > 8:
        report['warnings'].append('table_density_may_be_high')
    if len(image_indices) and len(captions) < len(image_indices):
        report['warnings'].append('some_images_may_lack_figure_captions')

    for idx, text in captions:
        prev = idx - 1
        while prev >= 0 and blocks[prev].tag == f'{{{W}}}p' and not p_text(blocks[prev]) and not has_image(blocks[prev]):
            prev -= 1
        if prev < 0 or not (blocks[prev].tag == f'{{{W}}}p' and has_image(blocks[prev])):
            report['warnings'].append(f'caption_not_immediately_below_image:{text[:30]}')

    texts = [p_text(p) for p in paras]
    required_logic = ['需求', '方案']
    for term in required_logic:
        if not any(term in t for t in texts):
            report['warnings'].append(f'missing_core_term:{term}')

    suspicious = re.search(r'(最终版\d+|new|修改版\d*|\d{8}[_-]\d{6})', path.stem, re.I)
    if suspicious:
        report['warnings'].append('filename_contains_nonformal_suffix')

    return report


def main() -> int:
    if len(sys.argv) != 2:
        print('usage: audit_docx_preferences.py <file.docx>')
        return 2
    report = audit(Path(sys.argv[1]))
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 1 if report['errors'] else 0


if __name__ == '__main__':
    raise SystemExit(main())
