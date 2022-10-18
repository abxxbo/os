[org 0x7e00]
%include "pcspkr.asm"

cli
xor ax, ax
mov ds, ax
mov es, ax

mov sp, 0x7e00
mov bp, sp
sti


PIT_IRQ_OFFSET equ 8*4
SYSCALL_OFFSET equ 0x80*0x04    ;; i think 0x200
                                ;; i will let the compiler decide
cli


mov word [PIT_IRQ_OFFSET], _irq0_isr
mov word [PIT_IRQ_OFFSET+2], ax


;; Interrupt for syscalls.
;; We will use int 0x80 (just like linux)
mov word [SYSCALL_OFFSET], _syscall_hdlr
mov word [SYSCALL_OFFSET+2], ax

sti

;; Set video mode
mov ah, 0x00
mov al, 0x03
int 0x10

;; Check for PCI in BIOS
mov ax, 0xB101
mov edi, 0x00000000 ;; Value taken from RBIL
int 0x1a

cmp ah, 0x00
jne _No_PCI


;; If the shell is executed, then we PCI
;; v2.0+ is installed on host.


;; Check for the RTL8139 chip
mov ax, 0xb102
mov cx, 0x8139 ;; device id
mov dx, 0x10ec ;; vendor id
int 0x1a
jc __RTL_Error ;; Error!
jnc _q

;; BEGIN ACTUAL CODE EXEC
_q:
  call get_ps1
  call prompt

  xor si, si
  jmp shell


jmp $

_No_PCI:
  mov bx, _No_PCI_M
  call printf
  jmp $

__RTL_Error:
  movzx bx, ah ;; <-- Status
  call printh

  cmp ah, 0x00  ;; Successful? But CF set, idk, jump to sub
  je .SubWTF
  jne .Sub2

  .Sub2:
    mov bx, __RTL_Err
    call printf
    jmp _q


  .SubWTF:
    mov bx, __RTL_Sub
    call printf
    jmp $


_No_PCI_M: db `[fatal] PCI v2.0 not installed\r\n`, 0

__RTL_Err: db `[non-fatal] RTL8139 is not detected (or some error), continuing...\r\n`, 0
__RTL_Sub: db `[idk?] I don't know what's going on. Halting..`, 0

ttessst: db 'EDIT    COM'
_foo2: times 256 db 0

;; Includes
%include "disk/disk.asm"

%include "io/shell.asm"

%include "arch/pit.asm"
%include "arch/syscalls.asm"


%include "datetime.asm"
%include "com.asm"

;;; Output
%include "output.asm"