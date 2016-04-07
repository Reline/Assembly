INCLUDE Irvine32.inc

.data
aa			SDWORD	?
raa			REAL4	?
bb			SDWORD	?
rbb			REAL4	?
cc			SDWORD	?
rcc			REAL4	?
realNum		SDWORD	?
squareRoot	REAL4	?
negSqrt		REAL4	?
negOne		SDWORD	-1
posTwo		REAL4	2.0

; STRINGS
promptA		BYTE	"Enter 'a': ", 0
promptB		BYTE	"Enter 'b': ", 0
promptC		BYTE	"Enter 'c': ", 0
badPrompt	BYTE	"Invalid input, enter an integer: ", 0
imaginary	BYTE	"Imaginary root(s)", 0

.code
invalid proc
	mov edx, OFFSET badPrompt
	call WriteString
	ret
invalid endp

main proc
	

getA:
	mov edx, OFFSET promptA
	mov esi, OFFSET aa
	call WriteString
	; validate input
	call ReadInt	; store user input in eax
	jno L1		; jump if no carry (valid int)
	call invalid
	jmp getA
L1: 
	mov [esi], eax

getB:
	mov edx, OFFSET promptB
	mov esi, OFFSET bb
	call WriteString
	; validate input
	call ReadInt	; store user input in eax
	jno L2			; jump if no carry (valid int)
	call invalid
	jmp getB
L2: 
	mov [esi], eax

getC:
	mov edx, OFFSET promptC
	mov esi, OFFSET cc
	call WriteString
	; validate input
	call ReadInt	; store user input in eax
	jno L3			; jump if no carry (valid int)
	call invalid
	jmp getC
L3: 
	mov [esi], eax

	; convert to float
	fild aa
	fstp raa
	fild bb
	fstp rbb
	fild cc
	fstp rcc

	; perform quadratic ; ax^2 + bx + c = 0 ; x = (-b +- (b^2 - 4ac)^-1) / 2a
	; b^2
	mov eax, bb
	imul eax
	mov ebx, eax ; ebx = b^2

	; -4ac
	mov eax, 4
	imul aa
	imul cc
	sub ebx, eax ; ebx = (b^2 - 4ac)

	; square root
	cmp ebx, 0 ; check if negative
	jl im ; imaginary number
	mov esi, OFFSET realNum
	mov [esi], ebx
	fild realNum
	fsqrt
	fstp squareRoot
	; squareRoot = (b^2 - 4ac)^-1

pm:	; +- ; plus minus
	fild negOne
	fmul squareRoot
	fstp negSqrt ; negSqrt = -(b^2 - 4ac)^-1) ; squareRoot = +(b^2 - 4ac)^-1)

	; -b
	fld squareRoot
	fsub rbb
	fstp squareRoot
	; squareRoot = -b+(b^2 - 4ac)^-1)
	fld negSqrt
	fsub rbb
	fstp negSqrt
	; negSqrt = -b-(b^2 - 4ac)^-1)

	; 1/2a
	fld squareRoot
	fld raa
	fmul posTwo ; st(1) = 2a
	fdiv 
	fstp squareRoot ; squareRoot = (-b+(b^2 - 4ac)^-1)) / 2a
	
	fld negSqrt
	fld raa
	fmul posTwo ; st(1) = 2a
	fdiv 
	fstp negSqrt ; negSqrt = (-b-(b^2 - 4ac)^-1)) / 2a

	; PRINT squareRoot and negSqrt
	; maybe i'll do printf someday...
	
	jmp done

im: ; imaginary number
	mov edx, OFFSET imaginary
	call WriteString

done:
	call Crlf
	call ReadChar
	ret
main endp
END