printf:
	mov ah, 0x0e
	.Loop:
	cmp [bx], byte 0
	je .Exit
		mov al, [bx]
		int 0x10
		inc bx
		jmp .Loop
	.Exit:
  	ret

printoasc:
    ;hex to ascii-hex
    add al, 30h
    cmp al, 39h
    jle printaback
    add al, 7h ;if letter
printaback:
    ret

printh:
	;output ch as 2 digit hex number
	mov al, ch
	and al, 0xf ;clear upper nibble, to get second digit only
	call printoasc
	mov ah, al ;store
	mov al, ch
	shr al, 4h ;get upper nibble, to get first digit only
	call printoasc
	mov ch, ah ;store
	;output two numbers
	mov ah, 0xe
	int 10h
	mov al, ch
	int 10h
	ret

print_newline:
	mov ah, 0x0e
	mov al, `\r`
	int 0x10

	mov ah, 0x0e
	mov al, `\n`
	int 0x10
	ret