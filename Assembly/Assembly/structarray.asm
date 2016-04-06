INCLUDE Irvine32.inc

.code
POINT STRUCT
   X WORD ?
   Y WORD ?
POINT ENDS

Rectangle STRUCT
   upperLeft POINT <>
   lowerRight POINT <>
Rectangle ENDS

.data
; create an array of three identical rectangles
myRectArray Rectangle 3 DUP(<<10,20>,<50,60>>)

.code
structarray proc
   mov esi, OFFSET myRectArray ; index 1
   add esi, SIZEOF Rectangle ; increment to index 2
   add esi, SIZEOF Rectangle ; increment to index 3
   mov eax, 80 ; ready 80 to move
   ; place 80 inside the current Rectangle.upperLeft.X
   mov (Rectangle PTR [esi]).upperLeft.X, ax 

   ret
structarray ENDP ; end main process

END