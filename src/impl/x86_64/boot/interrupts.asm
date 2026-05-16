bits 64
global isr_stub_table
extern exception_handler

; a macro to build an ISR stub for exceptions that dont push an error code
%macro ISR_NOERRCODE 1
global isr_stub_%1
isr_stub_%1:
    push qword 0      ; dummy error code
    push qword %1     ; vector number
    jmp isr_common
%endmacro

; a macro to build an isr stub for exceptions that do push an error code
%macro ISR_ERRCODE 1
global isr_stub_%1
isr_stub_%1:
    push qword %1     ; vector number
    jmp isr_common
%endmacro

; define the first 32 intel exceptions
ISR_NOERRCODE 0
ISR_NOERRCODE 1
ISR_NOERRCODE 2
ISR_NOERRCODE 3
ISR_NOERRCODE 4
ISR_NOERRCODE 5
ISR_NOERRCODE 6
ISR_NOERRCODE 7
ISR_ERRCODE   8
ISR_NOERRCODE 9
ISR_ERRCODE   10
ISR_ERRCODE   11
ISR_ERRCODE   12
ISR_ERRCODE   13
ISR_ERRCODE   14
ISR_NOERRCODE 15
ISR_NOERRCODE 16
ISR_ERRCODE   17
ISR_NOERRCODE 18
ISR_NOERRCODE 19
ISR_NOERRCODE 20
ISR_ERRCODE   21
ISR_NOERRCODE 22
ISR_NOERRCODE 23
ISR_NOERRCODE 24
ISR_NOERRCODE 25
ISR_NOERRCODE 26
ISR_NOERRCODE 27
ISR_NOERRCODE 28
ISR_ERRCODE   29
ISR_ERRCODE   30
ISR_NOERRCODE 31

; the common stub that preserves register state and calls C
isr_common:
    ; push all general purpose registers (save state)
    push rbp
    push rbx
    push r15
    push r14
    push r13
    push r12
    push r11
    push r10
    push r9
    push r8
    push rdi
    push rsi
    push rdx
    push rcx
    push rax

    ; call C handler
    call exception_handler

    ; restore registers (if exception_handler ever returned)
    pop rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop r8
    pop r9
    pop r10
    pop r11
    pop r12
    pop r13
    pop r14
    pop r15
    pop rbx
    pop rbp

    ; clean up vector number and error code
    add rsp, 16
    iretq             ; use iretq in 64-bit mode

section .data
isr_stub_table:
%assign i 0
%rep 32
    dq isr_stub_%+i
%assign i i+1
%endrep