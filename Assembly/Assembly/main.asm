INCLUDE Irvine32.inc ; included for DumpRegs use

.code ; indicates where code begins

main proc ; define our process name designated in the linker
	mov eax, 54
	; our values are represented using 16 bits in the dumpregs
	; 54 appears as 36 ; 3 groups of 16 and a leftover of 6
	call DumpRegs

	; subtracting 9 from 54 gives 45 ; 2 groups of 16 and remainder of 13, or D ; 2D
	sub eax, 9
	call DumpRegs

	; subtracting 20 from 45 is 25 ; 1 group of 16 and remainder of 9 ; 19
	sub eax, 20
	call DumpRegs

	ret ;ret gives back the value in the last register used (eax in this case)

	;call ExitProcess ; exits process. we want to see the dumpregs, so don't call this
main ENDP ; end our main process
END