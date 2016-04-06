INCLUDE Irvine32.inc ; included for DumpRegs use

.data ; variable initializations
	; all intrinsic data types ; the values associated have no real meaning
	; unsigned can hold a larger pos val, and no neg val
	; signed can hold pos and neg val
	bytez BYTE 1 ; 8-bit unsigned integer
	sbytez SBYTE -1 ; 8-bit signed integer
	wordz WORD 20 ; 16-bit unsigned integer
	swordsz SWORD -20 ; 16-bit signed integer
	dwordz DWORD 100.0 ; 32-bit unsigned integer ; d stands for double
	sdwordz SDWORD -100.0 ; 32-bit signed integer ; sd stands for signed double
	fwordz FWORD 9001 ; 48-bit integer ; far pointer in protected mode
	qwordz QWORD 10000 ; 64-bit integer ; q stands for quad
	tbytez TBYTE 999999999 ; 80-bit integer ; t stands for ten-byte
	realfour REAL4 5000.0 ; 32-bit IEEE short real
	realeight REAL8 100000.0 ; 64-bit IEEE long real
	realten REAL10 192031203.0 ; 80-bit IEEE extended real

.code ; indicates where code begins

datadef proc ; define our process name designated in the linker
	; 32-bit environment, so 32-bit registers and data sizes are the max
	mov eax, realfour
	call DumpRegs

	mov ebx, sdwordz
	sub eax, sdwordz
	call DumpRegs

	mov ecx, dwordz
	add eax, ecx
	call DumpRegs

	ret ;ret gives back the value in the last register used (eax in this case)

	;call ExitProcess ; exits process. we want to see the dumpregs, so don't call this
datadef ENDP ; end our main process
END