INCLUDE Irvine32.inc

.data
arrayA BYTE "ABCDEFGHI",0
arrayB BYTE LENGTHOF arrayA

.code
main proc
   mov ecx, LENGTHOF arrayA
   mov esi, OFFSET arrayA
   mov edi, OFFSET arrayB
L1:
   LODSB
   OR al, 00100000b
   call WriteChar
   STOSB
   loop L1

   ret
main ENDP ; end main process

END main ; end main.asm