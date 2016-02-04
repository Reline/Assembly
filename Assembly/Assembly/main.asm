INCLUDE Irvine32.inc ; included for DumpRegs use

.data ; variable initializations
	; all intrinsic data types ; the values associated have no real meaning
	; unsigned can hold a larger pos val, and no neg val
	; signed can hold pos and neg val
	
	wordz WORD 20 ; 16-bit unsigned integer
	swordz SWORD -20 ; 16-bit signed integer
	

.code ; indicates where code begins

main proc ; define our process name designated in the linker
	; 32-bit environment, so 32-bit registers and data sizes are the max
	mov ax, wordz ; put 20 in ax
	call DumpRegs

	mov bx, swordz ; put -20 in bx
	sub ax, bx ; 20 - (-20) = 40
	call DumpRegs

	sub ax, 40 ; 40 - 40 = 0
	call DumpRegs

	ret ;ret gives back the value in the last register used (eax in this case)

	;call ExitProcess ; exits process. we want to see the dumpregs, so don't call this
main ENDP ; end our main process
END