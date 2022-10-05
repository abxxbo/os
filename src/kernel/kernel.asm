[org 0x7e00]
cli
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7e00
mov bp, sp
sti


call get_ps1
call prompt

call printf
jmp shell

jmp $

;; Includes
%include "disk/disk.asm"
%include "disk/disk_ops.asm"

%include "io/shell.asm"

;;; Output
%include "output.asm"