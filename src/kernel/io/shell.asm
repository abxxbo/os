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
  mov bx, username
  call printf

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


get_ps1:
  ; mov di, 0xc00
	xor ax, ax
	mov es, ax
	
  mov si, HostnameFile
	call SearchFile
	cmp ah, byte 1		;; Error
	je $

	;; No error
	mov bx, 0xc00
	mov di, cx
  call LoadFile

	;; offset
	mov ax, word [0x9a00]
	mov word [username], ax
	
  ; jmp $
  ret

buffer: times 512 db 0

ps1: db `@someOS-> `, 0
username: db `  `, 0

HostnameFile: db `HOSTNA  TXT`, 0