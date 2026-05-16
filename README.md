# 64-bit hobby OS

A custom bare x86_64 bit operating system built from scratch using the GRUB bootloader.

---

## Features

* **Multiboot 2 compliant:** Boots using multiboot 2 compatible bootloader **GRUB.**
* **64 bit Long Mode:** Validates CPU via CPUID, sets up early 4-level paging (**PML4, PDPT, PD, PT**), and shifts from 32-bit protected mode into 64-bit.
* **VGA text mode driver:** Direct handling of the text buffer, featuring print text functions.
* **IDT & Interrupts:** Implements a 64-bit Interrupt Descriptor Table to handle CPU exceptions and remaps the 8259 PIC to process hardware interruptions

---

## Project Structure

```text
├── buildenv/                 # Dockerfile for the env
├── src/
│   ├── impl/x86_64/boot/     # Kernel source code
│   │   ├── kernel/
│   │   │   ├── idt.c         # IDT
│   │   │   └── main.c        # 64-bit kernel entry point
│   │   ├── header.asm        # Multiboot2 header definition
│   │   ├── interrupts.asm    # Low-level ISR assembly stubs
│   │   ├── main.asm          # 32-bit entry, paging, and long mode switch
│   │   ├── main64.asm        # 64-bit assembly wrapper
│   │   └── print.c           # VGA driver implementation
│   ├── intf/                 # Global header files (idt.h, print.h)
│   └── targets/x86_64/       # Linker script and ISO generation root
│       ├── iso/boot/grub/    # GRUB configuration (grub.cfg)
│       └── linker.ld         # Kernel memory layout definition
├── Makefile                  # Build automation script
└── Dockerfile                # Root environment setup
```

---

# Future plans

The long term goal is to evolve this bare kernel into a fully functional, useable desktop OS.
I would like to port basic libraries and applications to this hobby OS to test my developer capabilities (e.g minecraft).