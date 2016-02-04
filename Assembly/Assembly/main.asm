INCLUDE Irvine32.inc

.code ; indicates where code begins

main proc ; define our process name as getval
	mov eax, 54
	call DumpRegs
	ret ;ret gives back the value in the last register used (eax in this case)

	;call ExitProcess
main ENDP
END