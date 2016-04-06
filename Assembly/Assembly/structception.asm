INCLUDE Irvine32.inc

.code
POINT STRUCT
   X WORD ?
   Y WORD ?
POINT ENDS

POLY STRUCT
   points POINT 10 DUP(<>)
   numPoints WORD 10
POLY ENDS

.data
   aPoly POLY <>

.code
structception proc
   xor ecx, ecx
   mov cx, aPoly.numPoints ; save loop counter
   mov esi, OFFSET aPoly.points.X ; set first X memory location
L1: 
   call Randomize ; sets random seed
   mov eax, 99 ; determine range (0-99)
   call RandomRange ; get random number from range
   mov [esi], eax ; move random number into X
   add esi, SIZEOF POINT ; increment to next point
   loop L1 ; loop if we haven't done all points
   ret
structception ENDP ; end main process

END