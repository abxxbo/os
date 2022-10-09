[org 0x9b00]  ;; SomeOS loads COM files at 0x9b00 to execute it.

MAX_LEN equ 10

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
;; for now, my fat implementation does not support writing,
;; just reading. so for now, i will be using int 0x13

;; pre-interrupt setup
mov bx, cx    ;; move buffer into bx
mov ax, 0
mov es, ax

mov ah, 0x03
mov al, 1
mov ch, 0x00
mov cl, 25    ;; sector 25, this is 1.28 * 10^4 bytes out
mov dh, 0x00
mov dl, 0x00  ;; assume we're doing floppy
int 0x13

ret    ;; return back to executing code


;; data
welcome0: db `Welcome to the SomeOS editor. All you need to do is type. Once you reach 256 characters, it will save and exit\r\n\r\n`
welcome0_len equ $-welcome0
