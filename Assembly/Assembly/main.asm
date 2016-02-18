INCLUDE Irvine32.inc

.code ; indicates where code begins

main proc ; define our process name designated in the linker
	
	call Randomize ; sets random seed
	mov eax,1000 ; determines our range (0-1000)

	call RandomRange ; choose a random number from our range
	call WriteDec ; write our random number to the console

	; write newline
	mov eax, 0Ah
	call WriteChar

	call RandomRange ; choose a random number from our range
	call WriteDec ; write our random number to the console

	; write newline
	mov eax, 0Ah
	call WriteChar

	call RandomRange ; choose a random number from our range
	call WriteDec ; write our random number to the console

	; write newline
	mov eax, 0Ah
	call WriteChar

	call RandomRange ; choose a random number from our range
	call WriteDec ; write our random number to the console

	ret

	main ENDP ; end our main process
END