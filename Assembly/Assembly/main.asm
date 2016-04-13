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
















;memAlloc PROC memSize:DWORD, memDest:DWORD
; 	INVOKE HeapCreate, eax, memSize, memSize
; 	.IF eax == 0 ; heap not created
; 		mov edx, OFFSET error
; 		call WriteString	; show error message
; 	.ELSE
; 		mov esi, memDest ; memDest is a pointer value
; 		mov [esi], eax ; *memDest = eax
; 	.ENDIF
; 	ret
; memAlloc ENDP

; createNode PROC value:DWORD
; 	INVOKE memAlloc, SIZEOF Node, nextNodePtr ; *nextNodePtr = new Heap()
; 	mov eax, nextNodePtr
; 	mov (Node PTR[edi]).nextPtr, eax ; previousNode.nextPtr = nextNodePtr
; 	mov esi, nextNodePtr
; 	mov eax, value
; 	mov (Node PTR [esi]).val, eax ; nextNode.val = value
; 	ret
; createNode ENDP

; printNodes PROC
; 	cmp myList.head, 0
; 	je done
; 	mov esi, [myList.head]
; 	mov eax, (Node PTR[esi]).val
; 	call WriteDec
; 	mov eax, (Node PTR[esi]).nextPtr
; 	cmp eax, 0
; 	je done
; lp:
; 	mov esi, (Node PTR[esi]).nextPtr
; 	mov eax, (Node PTR[esi]).val
; 	call WriteDec
; 	mov eax, (Node PTR[esi]).nextPtr
; 	cmp eax, 0
; 	jne lp
; done:
; 	ret
; printNodes ENDP

; main PROC
; 	mov edi, OFFSET myList

; 	mov edx, OFFSET prompt
; 	call WriteString
; 	call ReadDec
; 	call Crlf
; 	cmp eax, 0
; 	je done

; 	; create node, set value to user input, and set prevNode.nextPtr to new node memLoc
; 	invoke createNode, eax
; 	mov eax, nextNodePtr
; 	mov [edi], eax ; myList.head = nextNodePtr

; cont: ; read user input
; 	mov edx, OFFSET prompt
; 	call WriteString
; 	call ReadDec
; 	call Crlf
; 	cmp eax, 0
; 	je done ; make a node if input not 0
	
; 	invoke createNode, eax ; create node and place ptr in nextNodePtr
; 	; move the pointer to the first node made into the head of myList
; 	; if not the first node, move the pointer to the node made into the previous node
; 	;mov [edi], nextNodePtr

	
; 	jmp cont

; done:
; 	call printNodes
	
; 	call ReadChar