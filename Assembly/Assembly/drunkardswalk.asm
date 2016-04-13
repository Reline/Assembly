; Drunkard's Walk              (Walk.asm)
; Drunkard's walk program. The professor starts at 
; coordinates 25, 25 and wanders around the immediate area.

INCLUDE Irvine32.inc
WalkMax = 50
StartX = 25
StartY = 25

DrunkardWalk STRUCT
     path COORD WalkMax DUP(<0,0>)
     pathsUsed WORD 0
DrunkardWalk ENDS
DisplayPosition PROTO currX:WORD, currY:WORD

.data
aWalk DrunkardWalk <>

.code
drunk PROC
     mov   esi,OFFSET aWalk
     call  TakeDrunkenWalk
     exit
drunk ENDP

;-------------------------------------------------------
TakeDrunkenWalk PROC
     LOCAL currX:WORD, currY:WORD
;
; Takes a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
    pushad
; Use the OFFSET operator to obtain the address of the
; path, the array of COORD objects, and copy it to EDI.
    mov  edi,esi
    add  edi,OFFSET DrunkardWalk.path
    mov  ecx,WalkMax           ; loop counter
    mov  currX,StartX          ; current X-location
    mov  currY,StartY          ; current Y-location
	mov ebx, 4                 ; default starting direction (North)
Again:
    ; Insert current location in array.
    mov  ax,currX
    mov  (COORD PTR [edi]).X,ax
    mov  ax,currY
    mov  (COORD PTR [edi]).Y,ax
    INVOKE DisplayPosition, currX, currY

	mov  eax,9				   ; 50% same direction, 10% backwards, 20% turn, 20% forwards
	call RandomRange
	.IF eax > 4				   ; Same direction
		.IF ebx > 2				; North
		dec currY
		.ELSEIF ebx > 1             ; West
		dec currX
		.ELSEIF ebx > 0             ; East
		inc currX
		.ELSE                       ; South
		inc currY
		.ENDIF
    .ELSEIF eax > 2            ; North
	mov ebx, eax
    dec currY
    .ELSEIF eax > 1            ; West
	mov ebx, eax
    dec currX
    .ELSEIF eax > 0			   ; East
	mov ebx, eax
    inc currX
    .ELSE                      ; South
	mov ebx, eax
    inc currY
    .ENDIF
    add edi,TYPE COORD	; point to next COORD
    dec cx
	jne Again
Finish:
    mov  (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
    popad

	mov eax, 10000
	call Delay

    ret
TakeDrunkenWalk ENDP
;-------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
;-------------------------------------------------------
.data
commaStr BYTE ",",0
.code
    pushad
    movzx  eax,currX            ; current X position
    call   WriteDec
    mov    edx,OFFSET commaStr  ; "," string
    call   WriteString
    movzx  eax,currY            ; current Y position
    call   WriteDec
    call   Crlf
    popad
    ret
DisplayPosition ENDP
END