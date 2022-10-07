[org 0x9b00]  ;; SomeOS loads COM files at 0x9b00 to execute it.

MAX_LEN equ 256

;; Write splash text.
mov ah, 0x01
mov bx, welcome0
mov cx, welcome0_len
int 0x80


;; Get user input, then save
mov ah, 0x02    ;; user input
mov bx, 1       ;; STDIN file descriptor
mov dx, MAX_LEN ;; 256 bytes
int 0x80

;; CX now has the buffer...
;; TODO: save file

ret           ;; return back to executing code


;; data
welcome0: db `Welcome to the SomeOS editor. All you need to do is type. Once you reach 256 characters, it will save and exit\r\n\r\n`
welcome0_len equ $-welcome0
