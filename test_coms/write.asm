mov ah, 0x01      ;; sys_write
mov bx, foo       ;; buffer to write
mov cx, 4         ;; buffer length
int 0x80
ret

foo: db 'Hello World', 0