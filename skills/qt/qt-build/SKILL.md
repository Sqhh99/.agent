---
name: qt-build
description: "Use when writing Qt CMake, versions, or QML modules."
version: 1.0.0
author: Sqhh99
license: MIT
---

# Qt 构建

**只认 CMake。禁止新建或继续维护 `.pro`。** 纯 C++/Qt 应用多数情况只改 `CMAKE_PREFIX_PATH` / preset 里的 Qt 路径，甚至不改。

档位按本机仓：Qt **5.14.2**、**6.8.3**、**6.10**。模板：`templates/CMakeLists.txt`。

## When to Use

- 写/改 Qt 工程的 CMake、preset、QML 模块、资源挂载
- Don't use for: 无 Qt 的纯库

## 版本

- **5.14.2**：`find_package(Qt5 5.14.2 …)`，或双找里的 Qt5 分支。新 MSVC 可能要兼容头（无人仓 `qt_msvc_compat.h`）。
- **6.8.3 / 6.10**：`find_package(Qt6 …)`；`qt_standard_project_setup()`。
- **双版本仓**（signal-generator / cbf / optical）：`find_package(QT NAMES Qt6 Qt5)` + `Qt${QT_VERSION_MAJOR}`。用 preset / `CMAKE_PREFIX_PATH` 换套件，**不要把 `D:/Qt/...` 写成唯一死路径**。
- 路径放 `CMakeUserPresets.json` 或环境变量；提交的 `CMakePresets.json` 给占位即可。

## CMake 开关

- 一律 `AUTOMOC` + `AUTORCC`。
- 有 `.ui` 才 `AUTOUIC`。
- Qt6：`qt_add_executable`；Qt5：`add_executable`。
- 入口脚本仍走 `cpp-build-system` 的 `build.cmd` / `build.sh`。

## Qt6 QML 资源

优先 `qt_add_qml_module(${PROJECT_NAME} … QML_FILES … RESOURCES …)`，**不要新加 .qrc**。样本：FLiNG、MusicPlayer、links。模板：`templates/qt_add_qml_module.cmake`。

Qt5 很少用 QML，不走这一条。

## Verification

- [ ] 仓库无新 `.pro`
- [ ] 换 Qt 路径能配置，不必改一堆 CMake
- [ ] Qt6 QML 仓用 `qt_add_qml_module`，不是新 qrc
