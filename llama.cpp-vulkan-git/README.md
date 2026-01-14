# llama.cpp-vulkan-git

LURE package for [llama.cpp](https://github.com/ggml-org/llama.cpp) with Vulkan GPU backend.

## Features

- **Vulkan GPU acceleration** using open-source Mesa drivers (RADV, ANV, NVK)
- **No proprietary blobs** required (unlike CUDA)
- **Heterogeneous inference** - offload layers to GPU while keeping rest on CPU
- **Systemd service** included for running as a server

## Dependencies

### Build
- `libvulkan-dev` - Vulkan headers and loader
- `glslc` - SPIR-V shader compiler (**critical** - from shaderc package)
- `glslang-tools` - Additional GLSL tools

### Runtime
- `libvulkan1` - Vulkan loader
- `mesa-vulkan-drivers` - Open-source Vulkan drivers

## Installation

```bash
# Install build dependencies first
sudo apt install libvulkan-dev glslc glslang-tools vulkan-tools

# Build with LURE
lure build

# Install the generated .deb
sudo apt install ./llama.cpp-vulkan-git_*.deb
```

## Quick Start

```bash
# Verify Vulkan support
vulkaninfo --summary

# List available compute devices
llama-cli --list-devices

# Run a model (auto-downloads from HuggingFace)
llama-cli -hf ggml-org/gemma-3-1b-it-GGUF -p "Hello!" -ngl 99

# Start the server
sudo systemctl enable --now llama.cpp
# Edit /etc/conf.d/llama.cpp to set your model path
```

## Systemd Service

Configuration file: `/etc/conf.d/llama.cpp`

```bash
# Start/stop
sudo systemctl start llama.cpp
sudo systemctl stop llama.cpp

# View logs
journalctl -u llama.cpp -f
```

## License

MIT (same as llama.cpp)
