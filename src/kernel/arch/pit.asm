_irq0_isr:
  mov al, 0x20
  out 0x20, al
  iret