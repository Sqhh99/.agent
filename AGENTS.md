# AGENTS.md

Sqhh99 的 agent skill 包。C++ 任务先读 [skills/cpp/cpp-engineering/SKILL.md](skills/cpp/cpp-engineering/SKILL.md)。Qt 界面再读 [skills/qt/qt-engineering/SKILL.md](skills/qt/qt-engineering/SKILL.md)。

`CLAUDE.md` 只指向本文件。改规则只改 `AGENTS.md` 或对应 `skills/<area>/*/SKILL.md`，不要在 `CLAUDE.md` 另写一套。

## Layout

```
AGENTS.md                 standing orders (this file)
CLAUDE.md                 pointer to AGENTS.md (Claude Code)
README.md                 human index
skills/<area>/<name>/     one category per area
  SKILL.md
  references/             optional
  templates/              optional
  scripts/                optional
  examples/               optional
```

当前分类：`skills/cpp/`、`skills/qt/`。新领域新建 `skills/<area>/`，不要把非 C++ skill 放进 `cpp/`。

C++ 地图：[skills/cpp/cpp-engineering/references/v2-map.md](skills/cpp/cpp-engineering/references/v2-map.md)

## Standing orders (C++)

1. 仓库里已有的规范优先于本包默认值。用户没要求重构就不要扩大 diff。
2. 构建入口是 `build.cmd` / `build.sh`（按平台需要给）。Debug / Release 分目录。
3. `cmake/Fetch*.cmake` 只下载 **Release 预编译包**，不要 FetchContent 编源码。编库走 vcpkg manifest。
4. 测试必须用框架（默认 GoogleTest）。新文件名 `test_*.cpp`，放在 `tests/unit|integration|benchmark/`。
5. 叙事归档：`docs/note|fix|feat|perf|refactor`，命名 `{YYYYMMDDHHmmss}-{标题}.md`。长期决策另写 `docs/adr/`。不是每个 commit 都归档。
6. 没跑过的编译/测试/硬件，不得写成通过。CRITICAL/HIGH 未清不得宣称完成。
7. 合入走分支 + PR，禁止直推 `main`。

## When adding a skill

- 先选 `skills/<area>/`，再创建 `<name>/SKILL.md`。
- `description` ≤ 60 字符，一句，以句号结尾，写清何时加载。
- 不是每个 skill 都要凑齐 references/scripts/templates/examples；有模板或长细则再加。
- 改完同步本仓；不要只改本机 `~/.hermes/skills/` 而不推。
