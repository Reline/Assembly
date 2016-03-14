INCLUDE Irvine32.inc

.data
count = 100
array WORD count DUP(?)

.code
main proc

    push OFFSET array
    push COUNT
    call ArrayFill

    mov esi,OFFSET array
    mov ecx,count
    mov ebx,2
    call DumpMem

SORT:
    mov edx, 0 ; finished = false
    mov esi,OFFSET array
    mov ecx,count
    call ArraySort
    cmp edx, 0 ; if finished == false
    jg SORT ; loop again

    mov esi,OFFSET array
    mov ecx,count
    mov ebx,2
    call DumpMem
	call Crlf

	; loop through array and print each ascii value
    mov esi,OFFSET array
    mov ecx,count
PRINT:
    mov eax, [esi]
    call WriteChar
    add esi,TYPE WORD
    loop PRINT

    ret
main endp

ArrayFill PROC
    push ebp
    mov ebp,esp
    pushad

    mov esi,[ebp+12]    ; offset of array
    mov ecx,[ebp+8]    ; array size
    cmp ecx,0
    jle L2
L1:
    mov eax,223 ; get random 32 -> 255
    call RandomRange
	add eax, 32
    mov [esi],eax
    add esi,TYPE WORD
    loop L1

L2: 
    popad
    pop ebp
    ret 8    ; clean up the stack
ArrayFill ENDP

ArraySort PROC
    mov ecx, count-1

L3: ; COMPARE
    mov eax, 0
    mov ebx, 0
    mov ax, [esi]
    mov bx, [esi+2] ; 2 bytes
    cmp eax, ebx ; compare current index to next index
    ja L4 ; jump if greater
    add esi, TYPE array ; increment index
    loop L3 ; decrement ecx
    ret

L4: ; SWAP
    inc edx ; indicate we swapped two values
    ; swap esi and esi-2
    mov [esi], bx
    mov [esi+2], ax
    add esi, TYPE array ; increment index
    loop L3
    ret

ArraySort ENDP

END main