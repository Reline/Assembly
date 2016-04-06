INCLUDE Irvine32.inc

.data
Node STRUCT
	val		DWORD	? ; node data
	nextPtr DWORD	? ; pointer to next node in list
Node ENDS

decNum		DWORD	?
listSize	DWORD	?
prompt		BYTE	"Enter an integer: ", 0
badPrompt	BYTE	"Invalid input, enter an integer: ", 0
head Node <>

.code
main proc
	
	xor eax, eax			; clear eax
	mov esi, OFFSET head	; store pointer to list

L1:
	; prompt user
	mov edx, OFFSET prompt
	call WriteString
L2: ; validate input
	call ReadInt	; store user input in eax
	jno L3			; jump if no carry (valid int)

	; invalid input
	mov edx, OFFSET badPrompt
	call WriteString
	jmp L2

L3: ; check input for 0 (end program)
	cmp eax, 0
	je L4
	; make new node
	mov (Node PTR [esi]).val, eax


	jmp L1

L4: ; print all nodes

	ret
main endp
END main
END