;; Nathan Reline
;; SPT323 Intro to Assembly

INCLUDE Irvine32.inc

.data ; variables
	array DWORD 10h,20h,30h,40h ; array of 32-bit unsigned doubles (16, 32, 48, 64)
	myString BYTE 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h; array of ten 8-bit unsigned integers

.code ; indicates where code begins

basics proc ; define our process name designated in the linker

	;; PRINT RANDOM NUMBER
	call Randomize ; sets random seed
	mov eax,999 ; determines our range (0-999)
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

	;; SHOW BINARY
	; save the size of the array (4)
	; 4 will be used to track how many times to continue the loop
    mov ecx,LENGTHOF array
	; OFFSET store the address of array, 
	; which points to the first number in the array
    mov esi,OFFSET array	
	; label our loop (L1)
	; place the current index of esi into eax to be printed
L1: mov eax,[esi]
	; print binary value of number to screen from eax
    call WriteBin
	; write newline
	mov eax, 0Ah
	call WriteChar
	; increment to the next number in the array by adding
    ; TYPE gets DWORD, representing the size needed
	; to increment between each value in the array
	add esi,TYPE array 
	; LOOP decrements ecx and checks if ecx is not zero, 
	; if that condition is met it jumps to L1, otherwise falls through
    loop L1

	;; STORE USER INPUT
    mov ecx,SIZEOF myString ; save loop increment count
    mov esi,OFFSET myString ; save memory address of myString
L2: call ReadChar ; read character into al register
    mov [esi],al ; save character into myString
	; print the characters we type to the screen
	mov eax,[esi]
	call WriteChar
    inc esi ; increments 8-bit register
    loop L2
	; write newline
	mov eax, 0Ah
	call WriteChar
	; print out word
	mov ecx,SIZEOF myString ; save loop increment count
    mov esi,OFFSET myString ; save memory address of myString
L3: mov eax,[esi]
	call WriteChar
    inc esi ; increments 8-bit register
    loop L3
	
    ret

	basics ENDP ; end our main process
END