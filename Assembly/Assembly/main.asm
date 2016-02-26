;; Nathan Reline
;; SPT323 Intro to Assembly

INCLUDE Irvine32.inc

; macro for changing text color
changeColor MACRO color
	.code
	mov eax, color+(black*16)
	call SetTextColor
	ENDM

.data
	str1 BYTE "Hurray colors", 0

.code ; indicates where code begins

main proc ; define our process name designated in the linker

mov ecx, 20 ; number of times to loop

; blue 10%, green 60%, white 30%
L1: call Randomize ; set random seed
	mov eax, 9 ; set random range (0-9) including
	call RandomRange ; move random number to eax
	cmp eax, 3
	je setBlue ; if 3, set blue
	jg setGreen ; if greater than 3, set green
	jmp setWhite ; else set white
	
setBlue: changeColor blue
		 jmp writeStr

setGreen: changeColor green 
		  jmp writeStr

setWhite: changeColor white
		  jmp writeStr

writeStr: mov edx, OFFSET str1 ; move our string to be written
		  call WriteString
	      call Crlf
		  dec ecx ; decrement our loop counter
		  cmp ecx,0
          jne L1 ; jump to L1 and run again if we haven't hit 20 loops
		  changeColor white
		  call Crlf
		  call WaitMsg
		  ret

	main ENDP ; end our main process
END