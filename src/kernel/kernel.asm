[org 0x0]

;; Set video mode
xor ah, ah
mov al, 3
int 0x10

jmp $

;; Interrupts


;; io
%include "io.asm"