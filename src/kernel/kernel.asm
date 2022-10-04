[org 0x7e00]

mov bx, test
call printf

jmp $

test: db `Hello World\r\n`, 0

;; Includes
;;; Output
%include "output.asm"