ListFiles:
  mov si, KernelFileName
  call SearchFile
  cmp ah, byte 1
  je Skip
  jne PrintName

  PrintName:
    mov bx, dx
    call printf

    mov ah, 0x0e
    mov al, ' '
    int 0x10

    ret

  Skip:
    ret

KernelFileName: db "KERNEL  BIN", 0