# Build 命令矩阵

脚本入口：`build.cmd`（Windows）、`build.sh`（Linux/mac，按需）。命令名必须一致。

| 命令 | 作用 |
| --- | --- |
| （空）或 `release` | 配置并编 Release |
| `debug` | 配置并编 Debug |
| `tests` | 打开测试、编译、跑 CTest |
| `benchmark` | 打开基准、编译、跑基准（没有基准目标可省略） |
| `configure` | 只配置，默认 Release，可跟 `debug` |
| `rebuild` | 删对应构建目录再编 |
| `clean` | 删 `build/` |
| `run` | 编完启动主程序（应用项目） |
| `help` | 打印用法 |

构建树示例：

```text
build/debug/
build/release/
```

或 FLiNG 风格 `build/ninja-debug`、`build/ninja-release`。

环境：`VCPKG_ROOT` 或仓库 `third_party/vcpkg`。Qt 等 SDK 用 `CMAKE_PREFIX_PATH`，不要把本机盘符写死进提交的 CMake。
