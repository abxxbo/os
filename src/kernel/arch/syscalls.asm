STDOUT_FD equ 0
STDIN_FD  equ 1

_syscall_hdlr:
  cmp ah, 0x01
  je _syscall_sys_write

  cmp ah, 0x02
  je _syscall_sys_read

  ;; exit interrupt

  .Leave:
    mov al, 0x20
    out 0x20, al
    iret


;; AH => 0x01
;; BX => buf
;; CX => bytes
;; DX => fd
_syscall_sys_write:
  cmp dx, STDOUT_FD
  je .Write
  

  .Write:
    mov ah, 0x0e  ;; AH does not matter, we already
                  ;; established it's equal to 1
    mov dx, 0
    .Loop:
      cmp dx, cx
      je _syscall_hdlr.Leave

      mov al, [bx]
      int 0x10    

      inc bx
      inc dx
      jmp .Loop

;; Input:
;; --- AH => 0x02
;; --- BX => file descriptor
;; --- CX => buffer
;; --- DX => amount of bytes to read 
_syscall_sys_read:
  cmp bx, STDIN_FD
  jg _syscall_hdlr.Leave
  ;; Do the same behaviour on both
  ;; STDOUT and STDIN

  ;; [cx] is 1st byte of buffer
  mov di, 0x00
  .Loop:
    cmp di, dx
    je .ReadyLeave  ;; exit once all bytes have been read

    xor ah, ah  ;; Destroy AH, we don't need it
    int 0x16    ;; get character

    ;; probably echo it?
    ;; idk
    printc al

    ;; update the buffer
    mov [__buffer+di], byte al

    inc di
    jmp .Loop

  .ReadyLeave:
    mov cx, [__buffer]
    jmp _syscall_hdlr.Leave


__buffer: times 256 db 0