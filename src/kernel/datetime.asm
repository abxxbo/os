print_date:
  mov ah, 0x04
  int 0x1a
  call printh
  mov ch, cl
  call printh
  mov al, '/'
  int 10h
  mov ch, dh
  call printh
  mov al, '/'
  int 10h
  mov ch, dl
  call printh
  printc ' '
  ret

;; TODO: make ...
print_time:
  mov ah, 0x02
  int 0x1a
  call printh ;; Hour
  printc ':'

  mov ch, cl
  call printh ;; Minute
  printc ':'

  mov ch, dh
  call printh ;; Second
  call print_newline
  ret
