%macro get_char 0
	xor ax, ax
	mov ah, 0x00
	int 0x16
%endmacro

%macro printc 1
	mov ah, 0x0e
	mov al, %1
	int 0x10
%endmacro

shell:
	get_char
	mov cl, al
	cmp cl, 13
	je .Enter

	cmp cl, 08
	je .Backspace
	jne .Print
	.Enter:
		mov si, 0
		printc `\r`
		printc `\n`

    cmp [buffer], dword "ls"
    je commands.ls

    call prompt
		;; jump back
		jmp shell
	.Backspace:
		dec si
		mov byte[buffer+si], byte `\0`

		;; get current cursor position
		mov ah, 0x03
		mov bh, 0
		int 0x10

		mov ch, dl
		mov bl, dh
		dec ch

		cmp dl, 3
		jl shell

		;; move cursor
		mov ah, 0x02
		mov bh, 0
		mov dl, ch
		mov dh, bl
		int 0x10

		jmp shell
	.Print:
		printc cl
		
		;; add CL to buffer
		mov byte [buffer+si], byte cl
		inc si

		;; Loop!
		jmp shell


prompt:
  ;; write ps1
  mov bx, ps1
  call printf
  ret


commands:
  .ls:
    call ListFiles
    printc `\r`
		printc `\n`
    call prompt
    mov si, 0x00
    .Loop:
      mov byte [buffer+si], byte 0
      inc si
      cmp si, 128
      je shell
  		jne .Loop

buffer: times 512 db 0
ps1: db `someOS-> `, 0