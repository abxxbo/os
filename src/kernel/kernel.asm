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

;; Check for PCI in BIOS
mov ax, 0xB101
mov edi, 0x00000000 ;; Value taken from RBIL
int 0x1a

cmp ah, 0x00
jne _No_PCI

;; If the shell is executed, then we PCI
;; v2.0+ is installed on host.

;; test sys_read
mov ah, 0x02
mov bx, STDIN_FD  ;; get input
mov cx, __test    ;; test buffer
mov dx, 2         ;; get two bytes
int 0x80

;; BEGIN ACTUAL CODE EXEC
call get_ps1
call prompt

xor si, si
jmp shell


jmp $
__test: db 0    ;; maybe?

_No_PCI:
  mov bx, _No_PCI_M
  call printf
  jmp $


_No_PCI_M: db `[fatal] PCI v2.0 not installed\r\n`, 0

;; Includes
%include "disk/disk.asm"

%include "io/shell.asm"

%include "arch/pit.asm"
%include "arch/syscalls.asm"


%include "datetime.asm"
%include "com.asm"

;;; Output
%include "output.asm"