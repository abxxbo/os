[org 0x7e00]
%include "pcspkr.asm"

cli
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7e00
mov bp, sp
sti

;; Set video mode
mov ah, 0x00
mov al, 0x03
int 0x10

;; Initialize drivers
;; ...
playsound 1193  ;; play sound


; stopsound


;; BEGIN ACTUAL CODE EXEC
call get_ps1
call prompt

call printf
jmp shell

;; Includes
%include "disk/disk.asm"
%include "disk/disk_ops.asm"

%include "io/shell.asm"

;;; Output
%include "output.asm"