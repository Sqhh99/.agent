---
name: qt-ui
description: "Use when designing Qt UI: .ui, QML, or widgets."
version: 1.0.0
author: Sqhh99
license: MIT
---

# Qt 界面

三种做法选一种，不要在同一窗口混三套。界面不写后端，后端不画界面。

## When to Use

- 加窗口、页面、控件、QML、.ui
- Don't use for: 协议、算法、无界面库

## 三种形态

**`.ui` + Widgets**  
Designer 管布局，cpp 只管槽和填数。`AUTOUIC`。目录：`app/` 或 `src/app/` + `pages/*.ui`。样本：optical-demod、cbf-btr。

**纯 C++ Widgets**  
无 uic。`ui/` 手写编辑器/面板。样本：signal-generator。

**QML + C++ 桥**  
QML 只做展示和交互；C++ `backend/` 业务、`app/` 当 model/controller。资源用 `qt_add_qml_module`（见 `qt-build`）。样本：links、FLiNG、MusicPlayer。

## 分层（推荐，不强制塞进 src/）

```text
app/        入口、主窗、桥
ui/         纯界面
view/       图表等可复用视图
model/      领域对象
engine/     编排
network/ protocol/  通信与编解码
resources/  图标与资源
examples/   控件演示 exe
docs/modules/  每模块一份 md
```

## 控件

可复用控件必须：

1. `examples/<control>/` 一个可运行 exe
2. 同目录或 `docs/modules/` 说明用法和效果

不要只丢一个 class 在库里。

## 模块文档

每个模块长期维护一份 md：职责、对外接口、线程、依赖。代码改了文档一起改。模板：`templates/module.md`。

## Verification

- [ ] 能指出本页是 .ui / 纯 Widgets / QML 哪一种
- [ ] QML 或 .ui 里没有协议解析
- [ ] 新控件有 examples exe + 说明
- [ ] 新模块有 md
