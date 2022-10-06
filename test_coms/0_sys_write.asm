mov ah, 0x01      ;; sys_write
mov bx, foo       ;; buffer to write
mov cx, foo_len   ;; buffer length
int 0x80

foo: db 'Hello World', 0
foo_len equ $-foo