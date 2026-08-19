---
name: cpp-project-layout
description: "Use when C++ 项目结构：apps、libs、include、tests。"
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ 工程结构

小项目可以用 `core` + UI。变大后禁止把所有逻辑塞进一个巨大 `core`。

## When to Use

- 新仓库、拆模块、评审目录是否会变成大泥球
- Don't use for: 只改一个已有文件且结构已稳定

## 默认分层

- **UI / apps 与领域逻辑解耦**。QWidget、窗口、绘图进 apps；领域库不依赖 GUI。
- 可复用代码做成**独立库 target**（动态或静态），不要只在可执行文件里堆源文件。
- 稳定公开接口放 `include/<project>/`。
- 自定义控件/库必须在 `examples/` 有可运行示例，并单独 `add_executable`。
- 资源统一 `resources/`（或历史目录 `resource/res`），不散落源码树。
- 不同类型可执行文件分目录，各有 `CMakeLists.txt`。

## 推荐骨架（按需裁剪）

```text
CMakeLists.txt  CMakePresets.json  vcpkg.json
.clang-format   .clang-tidy
cmake/          apps/   libs/   include/
tests/          examples/  tools/  docs/  resources/  third_party/
```

`libs/` 按领域切（protocol、device、algorithm、common），而不是一个无限长大的 `core/`。

已有仓若已是 `core/` 且还小：保持，不要为对齐模板而搬家。新模块优先新库目录。

## Verification

- [ ] GUI 头文件不进入领域库
- [ ] 公开头在 `include/`
- [ ] 每个可复用控件/库有 examples 可编可跑
- [ ] 资源不在源码目录里散落
