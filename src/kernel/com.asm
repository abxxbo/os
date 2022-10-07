;; jump to com and execute that code
;; SI -> file name
_COM_Exec:
  ;; assume that SI is the file name
  call SearchFile
  cmp ah, byte 1
  je $  ;; TODO: make this do something

  mov bx, 0xd00
  mov di, cx
  call LoadFile ;; load file to 0x9b00

  ;; jump to 0x9b00 and execute
  ;; that code
  call 0x9b00