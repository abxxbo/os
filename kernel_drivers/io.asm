;; out byte
%macro outb 2
  mov dx, %1
  mov al, %2
  out dx, al
%endmacro

%macro inb 1
  mov dx, %1
  in al, dx
%endmacro