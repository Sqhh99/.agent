# .agent

Sqhh99 的 C++ agent skills（V2.2）。接到任务先读 `skills/cpp-engineering`。

## 总控

- `cpp-engineering` — 工作流、先搜再写、计划步骤、真实性、评审挡板

## 工程底座

- `cpp-project-layout` — apps / libs，而不是无限 `core`
- `cpp-build-system` — build.cmd/sh；debug/release/tests；vcpkg + Fetch + CI
- `cpp-dependency-management` — vcpkg 编库；Fetch*.cmake 只拉 Release 预编译包
- `cpp-modern-cpp` — RAII、所有权、安全黑名单；深读 references/
- `cpp-design-and-comments` — 契约与「为什么」，允许 `.cpp` 必要注释
- `cpp-testing-contract` — `test_` 前缀；unit/integration/benchmark；必须 GTest
- `cpp-project-docs` — docs/note·fix·feat·perf·refactor，与 ADR 并存
- `cpp-debug-and-quality` — format 无辩论；CRITICAL/HIGH 挡合入
- `cpp-git-workflow` — GitHub Flow、rebase 红线、三点 diff、ADR
- `cpp-ci-release` — PR 门禁与 tag 发布

## 领域

- `cpp-qt-application` — UI 线程与 worker
- `cpp-device-io` — 协议、DMA、设备 I/O

模板在 `skills/cpp-engineering/templates/`。
