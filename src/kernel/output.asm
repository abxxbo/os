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


printn:
	mov cx, 0
	mov dx, cx

	.l1:
		cmp ax, 0
		je .print1

		mov bx, 10
		div bx

		push dx
		inc cx

		xor dx, dx
		jmp .l1
	.print1:
		cmp cx, 0
		je .exit

		pop dx
		add dx, 48
	
		mov ah, 0x0e
		
		xor bh, bh	;; zero out upper half
		mov al, dl	;; print lower half
		int 0x10

		dec cx
		jmp .print1

	.exit:
		ret


;; when the original wont cut it
printh_:
    push ax
    push bx
    push cx

    mov ah, 0Eh

    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    mov cx, 4

    printh_loop:
        cmp cx, 0
        je printh_end

        push bx

        shr bx, 12

        cmp bx, 10
        jge printh_alpha

            mov al, '0'
            add al, bl

            jmp printh_loop_end

        printh_alpha:
            
            sub bl, 10
            
            mov al, 'A'
            add al, bl


        printh_loop_end:

        int 0x10

        pop bx
        shl bx, 4

        dec cx

        jmp printh_loop

printh_end:
    pop cx
    pop bx
    pop ax

    ret