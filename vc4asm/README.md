# vc4asm

Macro assembler for Broadcom VideoCore IV (Raspberry Pi GPU).

## Description

vc4asm is an assembler and disassembler for the VideoCore IV GPU found in Raspberry Pi models 0-3. It allows writing QPU (Quad Processing Unit) assembly code for GPU compute tasks.

## Upstream

- **Homepage:** https://maazl.de/project/vc4asm/doc/index.html
- **Source:** https://github.com/maazl/vc4asm

## Included tools

- `vc4asm` — Assembler
- `vc4dis` — Disassembler
- `libvc4asm.so` / `libvc4asm.a` — Library

## Usage

```bash
# Assemble QPU code
vc4asm -o output.bin -V /usr/share/vc4inc/vc4.qinc input.qasm

# Disassemble
vc4dis -o output.qasm input.bin
```

## Notes

- Based on [Homebrew formula](https://github.com/Homebrew/homebrew-core/blob/master/Formula/v/vc4asm.rb)
- Includes GCC 9+ compatibility patch
