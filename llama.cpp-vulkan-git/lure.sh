#!/bin/bash
# LURE build script for llama.cpp with Vulkan backend
# Maintainer: Foad Sojoodi Farimani <f.s.farimani@gmail.com>

name="llama.cpp-vulkan-git"
version="0.0.0"  # Will be overridden by version()
release="1"
desc="Port of Facebook's LLaMA model in C/C++ (with Vulkan GPU optimizations)"
homepage="https://github.com/ggml-org/llama.cpp"
maintainer="Foad Sojoodi Farimani <f.s.farimani@gmail.com>"
architectures=("amd64" "arm64" "armv7h")
license=("MIT")
provides=("llama.cpp" "llama-server" "llama-cli" "llama-bench" "llama-quantize")
conflicts=("llama.cpp")
replaces=("llama.cpp")

# Build Dependencies
# CRITICAL: 'glslc' is the standalone SPIR-V compiler package
# libshaderc-dev provides the library, but NOT the glslc binary
# The CMake FindVulkan module specifically looks for the 'glslc' executable
build_deps_apt=(
    "git"
    "cmake"
    "build-essential"
    "pkg-config"
    "libvulkan-dev"      # Vulkan headers and loader
    "glslc"              # SPIR-V shader compiler (from shaderc) - REQUIRED!
    "glslang-tools"      # Additional GLSL tools (glslangValidator)
    "vulkan-tools"       # vulkaninfo for testing
    "libcurl4-openssl-dev"  # For model downloading
)

build_deps_pacman=(
    "git"
    "cmake"
    "base-devel"
    "pkg-config"
    "vulkan-headers"
    "vulkan-icd-loader"
    "shaderc"            # Provides glslc on Arch
    "glslang"
    "vulkan-tools"
    "curl"
)

# Runtime Dependencies
deps_apt=(
    "libvulkan1"         # Vulkan loader
    "mesa-vulkan-drivers"  # Open-source Vulkan drivers (RADV, ANV, etc.)
    "libcurl4"
)

deps_pacman=(
    "vulkan-icd-loader"
    "mesa"               # Includes Vulkan drivers
    "curl"
)

# Optional dependencies for model conversion
optdeps_apt=(
    "python3-numpy: convert_hf_to_gguf.py script"
    "python3-torch: convert_hf_to_gguf.py script"
)

sources=("git+https://github.com/ggml-org/llama.cpp.git")
checksums=("SKIP")

version() {
    cd "$srcdir/llama.cpp"
    # Debian requires version to start with a digit
    # Transform b7735-3-gd98b548120 -> 0.0.7735.r3.d98b548120
    # The 'b' prefix becomes part of the version number after 0.0.
    local ver
    ver="$(git describe --tags --long 2>/dev/null)"
    # Remove leading 'b', convert to: 0.0.BUILD.rCOMMITS.HASH
    printf "%s" "$(echo "$ver" | sed 's/^b//; s/\([^-]*\)-\([^-]*\)-g\(.*\)/0.0.\1.r\2.\3/')"
}

prepare() {
    cd "$srcdir/llama.cpp"

    # Initialize and update submodules if any
    git submodule update --init --recursive 2>/dev/null || true

    # --- Generate Default Config File ---
    cat > "$srcdir/llama.cpp.conf" << 'CONFEOF'
# Configuration for llama.cpp systemd service
# Edit this file, then run: sudo systemctl restart llama.cpp

# Model path (REQUIRED - set this to your model file)
LLAMA_MODEL="/var/lib/llama.cpp/models/default.gguf"

# Server address and port
LLAMA_HOST="127.0.0.1"
LLAMA_PORT="8080"

# GPU Layers to offload (set to 999 to offload all layers)
# Set to 0 for CPU-only inference
LLAMA_N_GPU_LAYERS="999"

# Context size (0 = use model default)
LLAMA_CTX_SIZE="0"

# Number of threads for CPU computation (0 = auto)
LLAMA_THREADS="0"

# Additional arguments (see llama-server --help)
# Examples: --embedding --metrics --flash-attn
LLAMA_ARGS=""
CONFEOF

    # --- Generate Systemd Service File ---
    cat > "$srcdir/llama.cpp.service" << 'SERVICEEOF'
[Unit]
Description=Llama.cpp Inference Server (Vulkan)
Documentation=https://github.com/ggml-org/llama.cpp
After=network.target

[Service]
Type=simple
User=nobody
Group=nogroup
EnvironmentFile=/etc/conf.d/llama.cpp

# Create model directory if it doesn't exist
ExecStartPre=/bin/mkdir -p /var/lib/llama.cpp/models

ExecStart=/usr/bin/llama-server \
    --model "${LLAMA_MODEL}" \
    --host "${LLAMA_HOST}" \
    --port "${LLAMA_PORT}" \
    --n-gpu-layers "${LLAMA_N_GPU_LAYERS}" \
    --ctx-size "${LLAMA_CTX_SIZE}" \
    --threads "${LLAMA_THREADS}" \
    ${LLAMA_ARGS}

Restart=on-failure
RestartSec=5

# Security hardening
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=/var/lib/llama.cpp
PrivateTmp=true

[Install]
WantedBy=multi-user.target
SERVICEEOF

    # --- Generate README for users ---
    cat > "$srcdir/README.post-install" << 'READMEEOF'
llama.cpp with Vulkan backend installed successfully!

QUICK START:
============

1. Test Vulkan support:
   vulkaninfo --summary

2. List available devices:
   llama-cli --list-devices

3. Download and run a model:
   llama-cli -hf ggml-org/gemma-3-1b-it-GGUF -p "Hello, world!" -ngl 99

4. Start the server:
   sudo systemctl enable --now llama.cpp
   # Edit /etc/conf.d/llama.cpp first to set your model path

For more information: https://github.com/ggml-org/llama.cpp
READMEEOF
}

build() {
    cd "$srcdir/llama.cpp"

    # Clean any previous build
    rm -rf build

    # Configure with CMake
    # Note: LLAMA_CURL is deprecated, curl support is automatic if libcurl is found
    cmake -B build \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DGGML_VULKAN=ON \
        -DGGML_NATIVE=ON \
        -DLLAMA_BUILD_TESTS=OFF \
        -DLLAMA_BUILD_EXAMPLES=ON \
        -DLLAMA_BUILD_SERVER=ON

    # Build with all available cores
    cmake --build build --config Release -j"$(nproc)"
}

package() {
    cd "$srcdir/llama.cpp"

    # Install using CMake
    DESTDIR="$pkgdir" cmake --install build

    # Install configuration file
    install -Dm644 "$srcdir/llama.cpp.conf" \
        "$pkgdir/etc/conf.d/llama.cpp"

    # Install systemd service
    install -Dm644 "$srcdir/llama.cpp.service" \
        "$pkgdir/usr/lib/systemd/system/llama.cpp.service"

    # Install license
    install -Dm644 "$srcdir/llama.cpp/LICENSE" \
        "$pkgdir/usr/share/licenses/$name/LICENSE"

    # Install documentation
    install -Dm644 "$srcdir/README.post-install" \
        "$pkgdir/usr/share/doc/$name/README"

    # Create model directory (will be owned by nobody:nogroup when service runs)
    install -dm755 "$pkgdir/var/lib/llama.cpp/models"
}
