[org 0x7e00]

call prompt
call get_ps1

call printf
jmp shell

jmp $

;; Includes
%include "disk/disk.asm"
%include "disk/disk_ops.asm"

%include "io/shell.asm"

;;; Output
%include "output.asm"