# .agent

Sqhh99 的 agent skills。按领域分目录，避免全部堆在 `skills/` 根下。

C++ 任务先读 [`skills/cpp/cpp-engineering`](skills/cpp/cpp-engineering/SKILL.md)。

## 分类

```
skills/
  cpp/     C++ 工程（构建、测试、文档、设备）
  qt/      Qt 上位机（CMake、三种界面、线程）
  github/  Git / PR / 分支
  # 其他领域以后加在这里
```

## skills/cpp/

### 总控

- `cpp-engineering` — 工作流、先搜再写、计划步骤、真实性、评审挡板

### 工程底座

- `cpp-project-layout` — apps / libs，而不是无限 `core`
- `cpp-build-system` — build.cmd/sh；debug/release/tests；vcpkg + Fetch + CI
- `cpp-dependency-management` — vcpkg 编库；Fetch*.cmake 只拉 Release 预编译包
- `cpp-modern-cpp` — RAII、所有权、安全黑名单；深读 references/
- `cpp-design-and-comments` — 契约与「为什么」，允许 `.cpp` 必要注释
- `cpp-testing-contract` — `test_` 前缀；unit/integration/benchmark；必须 GTest
- `cpp-project-docs` — docs/note·fix·feat·perf·refactor，与 ADR 并存
- `cpp-debug-and-quality` — format 无辩论；CRITICAL/HIGH 挡合入
- `cpp-ci-release` — PR 门禁与 tag 发布

### 领域（cpp）

- `cpp-device-io` — 协议、DMA、设备 I/O

## skills/qt/

- `qt-engineering` — 总控、线程、前后端、分层、控件 examples、模块文档
- `qt-build` — 只认 CMake；5.14 / 6.8.3 / 6.10；Qt6 用 qt_add_qml_module
- `qt-ui` — .ui / 纯 Widgets / QML

模板在 `skills/cpp/cpp-engineering/templates/`。

## skills/github/

- `git-workflow` — GitHub Flow、rebase 红线、三点 diff、ADR
