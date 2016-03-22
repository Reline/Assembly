INCLUDE Irvine32.inc

.data
count = 65000 ; 'roof' for prime number search
prompt BYTE "Prime numbers from 0-", 0
done BYTE "Done", 0

.data?
array DWORD count DUP(?) ; declare array in uninitialized data segment

.code
main proc
	
	; zero out array
	mov esi, OFFSET array
	mov ecx, count
L1: mov eax, 0
	mov [esi], eax
	add esi, TYPE array
	loop L1

	; move back to beginning of array
	mov esi, OFFSET array ; 1
	add esi, TYPE array ; 2
	add esi, TYPE array ; 3
	mov ecx, 3 ; store current index in ecx ; 1st index = 1st element
	mov ebx, 2 ; store current prime number

L2: ; skip if current index equals current prime number
	cmp ecx, ebx
	je con
	; DIV stores the quotient in AX and remainder in DX
	mov eax, ecx
	xor edx, edx
	div bx
	; if the remainder is 0, set current index to composite
	cmp dx, 0
	jnz con
	mov eax, [esi]
	mov eax, 1
	mov [esi], eax

	; go to next index if we haven't finished searching with current prime number
con: add esi, TYPE array
	inc ecx
	cmp ecx, count
	jle L2

	; set esi back to the correct index
	mov esi, OFFSET array
	mov ecx, 1
L3: add esi, TYPE array
	inc ecx
	cmp cx, bx
	jne L3
	
	; find the next prime number
L4: add esi, TYPE array
	inc ecx
	; check if we reached the end of the array and found no new prime numbers
	cmp ecx, count
	jg L5 ; quit if we have gone past the array
	; if value at current index = 0, set new prime number
	mov eax, [esi]
	mov eax, 0
	cmp [esi], eax
	jnz L4
	mov ebx, ecx
	jmp L2

	
L5:	; print entire array
	;mov esi, OFFSET array
	;mov ecx, 1
;L7: mov eax, ecx
	;call WriteDec
	;call Crlf
	;mov eax, [esi]
	;call WriteDec
	;call Crlf
	;call Crlf
	;inc ecx
	;add esi, TYPE array
	;cmp ecx, count
	;jle L7

	; print all prime numbers
	mov edx, OFFSET prompt
	call WriteString
	mov eax, count
	call WriteDec
	call Crlf
	call Crlf
	mov esi, OFFSET array
	; 1 is not a prime number, so skip it
	mov ecx, 2
	add esi, TYPE array
L6: mov eax, ecx
	mov eax, 0
	cmp [esi], eax
	jnz composite
	mov eax, ecx
	call WriteDec
	call Crlf
composite:	add esi, TYPE array
	inc ecx
	cmp ecx, count
	jle L6
	
	mov edx, OFFSET done
	call Crlf
	call WriteString

	ret
main ENDP

END main