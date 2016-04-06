INCLUDE Irvine32.inc

.data
aa			SDWORD	?
bb			SDWORD	?
cc			SDWORD	?
int32		SDWORD	?
squareRoot	SDWORD	?
promptA		BYTE	"Enter 'a': ", 0
promptB		BYTE	"Enter 'b': ", 0
promptC		BYTE	"Enter 'c': ", 0
badPrompt	BYTE	"Invalid input, enter an integer: ", 0
imaginary	BYTE	"Imaginary root(s)", 0
leftParen	BYTE	"(", 0
plusMin		BYTE	"+-(", 0
rightParen	BYTE	")^-1)", 0
divide		BYTE	"----------------------", 0
spaces		BYTE	"          ", 0

.code
invalid proc
	mov edx, OFFSET badPrompt
	call WriteString
	ret
invalid endp

quadraticformula proc
	

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
	mov esi, OFFSET int32
	mov [esi], ebx
	mov eax, int32
	fild int32
	fsqrt
	fistp squareRoot ; this #^2 is the closest value to int32
	mov eax, squareRoot
	imul eax
	cmp ebx, eax
	jne np ; not perfect
	mov ebx, squareRoot
	; ebx = (b^2 - 4ac)^-1

pm:	; +- ; plus minus
	mov eax, -1
	imul ebx ; eax = -(b^2 - 4ac)^-1) ; ebx = +(b^2 - 4ac)^-1)

	; -b
	sub eax, bb 
	xchg eax, ebx
	sub eax, bb
	mov ecx, eax ; ebx = -b-(b^2 - 4ac)^-1) ; ecx = -b+(b^2 - 4ac)^-1)

	; 1/2a
	mov eax, 2
	imul aa ; eax = 2a
	xchg eax, ecx
	idiv ecx ; eax = (-b+(b^2 - 4ac)^-1)) / 2a
	call Crlf
	call WriteInt
	call Crlf
	xchg eax, ebx
	idiv ecx ; eax = (-b-(b^2 - 4ac)^-1)) / 2a
	call WriteInt

	jmp done

im: ; imaginary number (or not simplified)
	mov edx, OFFSET imaginary
	call WriteString
	call Crlf
np:	; ebx = (b^2 - 4ac)
	mov eax, -1
	imul bb 
	mov ecx, eax ; ecx = -b
	mov eax, 2
	imul aa ; eax = 2a
	call Crlf

	; PRINT: '(' + ECX + '+-(' + EBX + ')^-1)'
	mov edx, OFFSET leftParen
	call WriteString
	xchg ecx, eax
	call WriteInt
	mov edx, OFFSET plusMin
	call WriteString
	xchg ebx, eax
	call WriteInt
	mov edx, OFFSET rightParen
	call WriteString
	call Crlf
	; PRINT: '-------------------------------'
	mov edx, OFFSET divide
	call WriteString
	call Crlf
	; PRINT: '            EAX                '
	mov edx, OFFSET spaces
	call WriteString
	xchg ecx, eax
	call WriteDec
	call WriteString

done: nop
	ret
quadraticformula endp
END quadraticformula