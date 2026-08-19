---
name: cpp-qt-application
description: "Use when building or reviewing Qt C++ desktop UI."
version: 2.0.0
author: Sqhh99
license: MIT
---

# Qt 上位机

UI 线程与采集/网络/设备线程必须分开。本 skill 不管算法和协议细节。

## When to Use

- Qt Widgets/QML 窗口、信号槽、Model/View、资源、QThread
- Don't use for: 无 Qt 的库/CLI；纯协议解析（用 `cpp-device-io`）

## 规则

- **QObject 所有权**：父子树或明确 `deleteLater`。跨线程不要裸 `new` 完交给另一线程乱删。
- **信号槽**：跨线程用 queued 连接。槽里做的事先问「这是不是 UI 线程」。
- **禁止阻塞 UI**：设备读写、解析、文件、等待应答都在 worker。UI 只收状态/数据副本。
- Worker：`QObject` + `moveToThread` 或明确的 `QThread` 子类；对象亲和性要写清。
- Model/View：大数据用 model，不在 UI 里堆 widget。
- 资源走 Qt 资源系统或项目 `resources/`，不要把大图编进每个 cpp。
- 事件循环假设：没有 exec 的线程不要投递需要事件循环的对象。

## 和 core 的边界

- UI 只依赖应用层/接口，不把 QWidget 头文件引进 `libs/` 领域库。
- 设备回调进 UI：拷贝到值类型或不可变快照，再 signal 出去。

## Verification

- [ ] 主线程无同步设备 I/O
- [ ] 跨线程对象有明确 affinity 与销毁顺序
- [ ] 领域库不 `#include` Qt GUI 头
