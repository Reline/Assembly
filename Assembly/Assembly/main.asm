INCLUDE Irvine32.inc

.data
source BYTE "ABC",0
target BYTE "123ABC342432",0
pos DWORD ?

.code
;--------------------------------------------------------- 
; Str_find 
; 
; Searches for first matching occurence of a source string 
; inside a target string and returns the matching position.
; Receives: EAX (source string) and EBX (target string)
; Returns: found: EAX = index, ZF = 1
;		   not found: EAX = undefined, ZF = 0
;---------------------------------------------------------
	
Str_find proc uses esi edi
	xor ecx, ecx
	mov edx, LENGTHOF source
	dec edx ; don't count null terminator
L1: 
	mov eax, [esi]
	mov ebx, [edi]
	; inc src if we find a char that matches
	cmp al, bl
	jnz L2
	; if equal
	inc esi ; increment source
	inc edi ; increment target
	inc ecx ; increment current index of target
	dec edx ; decrement number of characters left to compare in source
	; end if found whole string
	cmp edx, 0
	jz success
	jmp L1
	
L2: ; if not equal
	inc edi ; increment target
	inc ecx ; increment current index of target
	mov edx, LENGTHOF source ; reset characters to compare in source
	dec edx ; don't count null terminator
	; if target is too small to contain source, end
	mov eax, LENGTHOF target
	dec eax ; don't count null terminator
	sub eax, ecx
	sub eax, edx
	cmp eax, 0
	jge L1
	jmp fail

success:
	mov ah, 1000000b ; set zero flag to 1
	sahf ; copy into flags register
	mov eax, ecx ; set eax to index where string was found
	sub eax, LENGTHOF source
	inc eax ; don't count null terminator
	ret

fail:
	mov ah, 0b ; set zero flag to 0
	sahf ; copy into flags register
	mov eax, 0 ; set eax to undefined (0)
	ret

Str_find endp

main proc
	; move pointers to registers
	mov esi, OFFSET source
	mov edi, OFFSET target
	call Str_find
	jnz notFound
	mov pos, eax

notFound:
	nop

	call WriteDec
	ret
main ENDP ; end main process

END main ; end main.asm