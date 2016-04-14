; Linked List

INCLUDE Irvine32.inc

.data
Node STRUCT
	val		DWORD	? ; node data
	nextPtr DWORD	0 ; pointer to next node in list
Node ENDS

prompt		BYTE		"Enter a value for a node: ", 0
badInput	BYTE		"Invalid input.", 0
error		BYTE		"Error: Heap not created.", 0
headNodePtr	DWORD 	0
nextNodePtr	DWORD 	OFFSET headNodePtr

.code
memAlloc PROC memSize:DWORD, memDest:DWORD
	; allocate memory
	invoke GetProcessHeap
	invoke HeapAlloc, eax, HEAP_ZERO_MEMORY, memSize ; initializes all allocated memory to 0
	.IF eax == 0 ; check for heap allocation
		mov edx, OFFSET error
		call WriteString
		ret	
	.ENDIF

	; DEBUG ; print memory address of current node
	; call WriteDec
	; call Crlf

	; compare head & current node to check if first node
	mov ecx, OFFSET headNodePtr
	mov ebx, [nextNodePtr]
	.IF ecx == ebx ; first node
		mov headNodePtr, eax
		mov nextNodePtr, eax
	.ELSE ; 2... node
		; move start of allocated memory address to nextPtr variable
		mov esi, [memDest]
		mov [esi], eax
		mov nextNodePtr, eax
	.ENDIF

	ret
memAlloc ENDP

createNode PROC value:DWORD
	; allocate memory & move start of allocated memory address to nextNodePtr
	invoke memAlloc, SIZEOF Node, nextNodePtr ; eax = *memLoc

	; move to the start of the allocated memory address (newNode.val)
	mov edi, eax

	; place the value in memory (newNode.val = value)
	mov ebx, value
	mov [edi], ebx

	; move to the pointer position in memory (newNode.nextPtr)
	add nextNodePtr, SIZEOF DWORD

	ret
createNode ENDP

printNodes PROC
	; move to the head node
	mov eax, [headNodePtr]
 	mov nextNodePtr, eax ; nextNodePtr = headNodePtr

L1:	; move to the current node in memory
	mov esi, [nextNodePtr]

	; DEBUG ; print memory address of current node
	; mov eax, esi
	; call WriteDec
	; call Crlf

	; print the value of the current node
	mov eax, [esi]
	call WriteDec
	call Crlf

	; increment to the next pointer variable
	add esi, SIZEOF DWORD

	; move the next pointer variable into our current node
	mov ebx, [esi]
	mov nextNodePtr, ebx

	; repeat while the next pointer is not 0
	cmp nextNodePtr, 0
	jne L1
	ret

printNodes ENDP

promptUser PROC
L1: ; prompt user for node value
	mov edx, OFFSET prompt
	call WriteString
	call ReadDec
	jno L2 ; validate input

	call Crlf
	mov edx, OFFSET badInput
	call Crlf
	jmp L1

L2:	; end if input is zero
	cmp eax, 0
	je done

	invoke createNode, eax
	jmp L1

done:
	ret
promptUser ENDP

main PROC
	invoke promptUser
	call Crlf

	call printNodes
	call ReadChar
	ret
main ENDP
END
