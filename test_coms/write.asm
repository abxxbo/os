[org 0x9b00]
mov ah, 0x01      ;; sys_write
mov bx, foo       ;; buffer to write
mov cx, foo_len   ;; buffer length
int 0x80

ret

foo: db `Hello from a COM file!\r\n`
foo_len equ $-foo