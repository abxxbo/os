%include "io.asm"

;; %1 --> frequency divided by 1193180
%macro playsound 1
  outb 0x43, 0xb6
  outb 0x42, %1

  ;; outb(0x42, (uint8_t)Div >> 8)
  mov al, %1
  sar al, 8
  outb 0x42, al

  inb 0x61
  mov bl, al
  or bl, 3

  cmp al, bl
  jne %%Last

  %%Last:
    outb 0x61, bl
%endmacro


%macro stopsound 0
  ;; tmp = inb(0x61) & 0xfc
  inb 0x61
  and al, 0xfc

  outb 0x61, al
%endmacro