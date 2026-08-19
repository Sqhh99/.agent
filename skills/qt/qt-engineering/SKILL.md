---
name: qt-engineering
description: "Use when starting or reviewing a Qt desktop app."
version: 1.0.0
author: Sqhh99
license: MIT
---

# Qt 工程总控

接到 Qt 上位机任务先走这里，再加载 `qt-build`、`qt-ui`。C++ 底座仍用 `skills/cpp/`（构建脚本、测试、Fetch、文档）。

## When to Use

- 新 Qt 窗口、改界面、拆前后端、加控件、看线程
- Don't use for: 无 Qt 的库/CLI；纯协议（`cpp-device-io`）

## 判定

1. Qt 档：5.14.2 / 6.8.3 / 6.10（或仓内已钉的 6.x）
2. 界面：`.ui` / 纯 Widgets / QML
3. 构建：只能 CMake，禁止 `.pro`

然后读 `qt-build` + `qt-ui`。

## 线程与所有权（从原 cpp-qt-application 整段迁入）

- **QObject 所有权**：父子树或明确 `deleteLater`。跨线程不要裸 `new` 完交给另一线程乱删。
- **信号槽**：跨线程 queued。槽里先问是不是 UI 线程。
- **禁止阻塞 UI**：设备、解析、文件、等应答都在 worker。UI 只收状态/数据副本。
- Worker：`QObject` + `moveToThread` 或明确 `QThread` 子类；affinity 写清。
- Model/View：大数据用 model，不在 UI 里堆控件。
- 没有 `exec` 的线程不要投递需要事件循环的对象。

## 前后端

- 界面代码不写业务/协议/设备逻辑。
- 后端/领域不写布局、样式、QML、QWidget。
- 中间用值类型或不可变快照 + signal；设备回调不要直接碰控件。
- 领域库禁止 `#include` Qt GUI / Quick 头。

## 分层

不强制所有代码进 `src/`。按层分目录（`app/` `ui/` `model/` `engine/` `network/` `protocol/` `view/`），参考 signal-generator、optical-demod、MusicPlayer。小工具可以扁，变大再拆。

## 控件与模块文档

- 可复用控件：`examples/` 里单独 exe 展示用法和效果，并配说明 md。
- 每个模块长期维护一份 md（`docs/modules/<name>.md` 或模块目录 `README.md`），接口/职责变了要改文档。

## Verification

- [ ] 主线程无同步设备 I/O
- [ ] 界面文件里没有协议/设备细节
- [ ] 领域代码没有 QWidget/QML
- [ ] 新模块有对应 md
