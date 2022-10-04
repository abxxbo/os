ListFiles:
  mov si, KernelFileName
  call SearchFile
  cmp ah, byte 1
  je Skip
  jne PrintName

  PrintName:
    mov bx, dx
    call printf

    mov ah, 0x20
    call printc
    
    ret

  Skip:
    ret

KernelFileName: db "KERNEL  BIN"