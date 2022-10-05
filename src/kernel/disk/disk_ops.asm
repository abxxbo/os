ListFiles:
  mov si, KernelFileName
  call SearchFile
  cmp ah, byte 1
  je .Skip
  call .PrintName

  mov si, HostnameFile
  call SearchFile
  cmp ah, byte 1
  je .Skip
  call .PrintName

  .PrintName:
    mov bx, dx
    call printf

    mov ah, 0x0e
    mov al, ' '
    int 0x10
    ret

  .Skip:
    mov ah, 0x0e
    mov al, 0x66
    int 0x10
    
    ret
  

KernelFileName: db "KERNEL  BIN", 0