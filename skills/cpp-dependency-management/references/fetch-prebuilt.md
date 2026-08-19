# Fetch*.cmake = 预编译 Release，不是编源码

对照：

| | vcpkg | Fetch*.cmake |
| --- | --- | --- |
| 输入 | port 源码 | 上游 release 的 zip/tgz |
| 本机 | 编译 | 只下载、解压、对路径 |
| 适合 | 中小型开源库 | ONNX Runtime、LiveKit、FFmpeg 预编译、厂商 SDK |

清单：

- URL 钉到具体 tag，例如 `.../releases/download/v1.27.0/onnxruntime-win-x64-1.27.0.zip`
- 按 `CMAKE_SYSTEM_NAME` + arch 选包名
- 解压后必须能找到 `include/` 和 `lib/`
- 已存在则跳过；失败删半截包
- 尽量校验 SHA256
- 不要 `FetchContent_Declare(GIT_REPOSITORY ...)` 当 Fetch 脚本

样本：`FetchONNXRuntime.cmake`、`FetchLiveKitSDK.cmake`、`FetchFFmpeg.cmake`。
