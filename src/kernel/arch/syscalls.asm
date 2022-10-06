_syscall_hdlr:
  cmp ah, 0x01
  je _syscall_sys_write

  ;; exit interrupt

  .Leave:
    mov al, 0x20
    out 0x20, al
    iret


;; AH => 0x01
;; BX => buf
;; CX => bytes
_syscall_sys_write:
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