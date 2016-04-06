INCLUDE Irvine32.inc

.data
myString BYTE "abCDefg123hij",0

.code
lowtoup proc
	mov esi, OFFSET myString
L1: mov al, [esi]
	cmp al, 0
	je L3
	cmp al, 'a'
	jb L2

	cmp al, 'z'
	ja L2
	and BYTE PTR [esi], 11011111b
L2: inc esi
	jmp L1
L3: 
	ret
lowtoup ENDP ; end main process

END