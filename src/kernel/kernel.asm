[org 0x7e00]
%include "pcspkr.asm"

cli
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7e00
mov bp, sp
sti


PIT_IRQ_OFFSET equ 8*4
SYSCALL_OFFSET equ 0x80*0x04    ;; i think 0x200
                                ;; i will let the compiler decide
cli


mov word [PIT_IRQ_OFFSET], _irq0_isr
mov word [PIT_IRQ_OFFSET+2], ax


;; Interrupt for syscalls.
;; We will use int 0x80 (just like linux)
mov word [SYSCALL_OFFSET], _syscall_hdlr
mov word [SYSCALL_OFFSET+2], ax

sti

;; Set video mode
mov ah, 0x00
mov al, 0x03
int 0x10


;; BEGIN ACTUAL CODE EXEC
call get_ps1
call prompt

xor si, si
jmp shell

;; Includes
%include "disk/disk.asm"
%include "disk/disk_ops.asm"

%include "io/shell.asm"

%include "arch/pit.asm"
%include "arch/syscalls.asm"


%include "datetime.asm"

;;; Output
%include "output.asm"