---
name: cpp-device-io
description: "Use when C++ talks to serial, TCP, DMA, or PCIe."
version: 2.0.0
author: Sqhh99
license: MIT
---

# C++ 设备与二进制协议

串口、TCP/UDP、PCIe、DMA、驱动接口。重点是帧、超时和缓冲区寿命，不是「把字节读进来」。

## When to Use

- 写/改采集、识别包、XDMA、匹配滤波数据、自定义二进制协议
- Don't use for: 纯 UI；与设备无关的算法数值代码

## 规则

- **字节序、对齐、packing** 写进协议头注释和测试。禁止在协议结构体上默认依赖编译器 padding。
- 帧：长度、头尾、CRC/校验、粘包/半包。读循环必须能处理 partial read。
- 超时、重试、断连、重连是一等契约，不是事后补丁。
- 缓冲区寿命：谁分配、对齐要求（如 DMA 4096）、谁释放、能否在回调返回后仍被 DMA 写。
- 需要零拷贝时，接口用 `span` + 明确的 pin/unpin；默认先正确再优化。
- 反压：队列有上限，满了要丢策略或阻塞策略，禁止无限涨。
- 线程安全：一句话写清「哪条线程拥有 fd/handle」。
- 没有真机：用 mock/录包做集成；回复里标「未做硬件验证」。

## 禁止

- 把 packed 结构体直接 `reinterpret_cast` 到未对齐缓冲然后当本地对象用（按平台处理）
- 忽略 short write/read
- 在 UI 线程里等设备

## Verification

- [ ] 有半包/粘包/超时用例，或明确为何本协议不会出现
- [ ] DMA/大缓冲的对齐与寿命有注释（这是允许且应当写在 `.cpp` 的那种）
- [ ] 无真机时未验证项已列出
