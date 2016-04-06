INCLUDE Irvine32.inc

.data
COUNT = 5

arrayA DWORD COUNT DUP(?)
arrayB DWORD COUNT DUP(?)

.code
ArrayFill PROC
    push ebp
    mov ebp,esp
    pushad

    mov esi,[ebp+12]    ; offset of array
    mov ecx,[ebp+8]    ; array size
    cmp ecx,0
    jle L2
L1:
    mov eax,25 ; get random 97 -> 122
    call RandomRange
   add eax, 97
   call WriteChar
    mov [esi],eax
    add esi,TYPE DWORD
    loop L1

L2: 
    popad
    pop ebp
    ret 8    ; clean up the stack
ArrayFill ENDP

reversecmp proc

   ; fill our arrays with random characters (a-z lowercase)
   push OFFSET arrayA
   push COUNT
   call ArrayFill
   call Crlf

   push OFFSET arrayB
   push COUNT
   call ArrayFill
   call Crlf

   mov ecx, COUNT ; set our counter
   mov esi, OFFSET arrayA ; set our pointer to the beginning of arrayA
   add esi, SIZEOF arrayA ; increment the pointer to the end of the array
   mov edi, OFFSET arrayB ; set our pointer to the beginning of arrayB
   add edi, SIZEOF arrayB ; increment the pointer to the end of the array
L1:
   sub esi, TYPE arrayA ; decrement through arrayA
   mov eax, [esi] ; move our char from arrayA into eax
   sub edi, TYPE arrayB ; decrement through arayB
   mov ebx, [edi] ; move our char from arrayB into ebx
   cmpsd ; compare values at current index (ecx)
   jne L2 ; if value are not equal, end
   loop L1 ; if values are equal, loop again while not yet reached beginning of array

L2: 
   call DumpRegs
   ret
reversecmp ENDP ; end main process

END