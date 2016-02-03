ExitProcess PROTO

.code ; indicates where code begins

getval proc ; define our process name as getval
	mov rax, 1564
	mov eax, 54
	ret ;ret gives back the value in the last register used (eax in this case)

	;call ExitProcess
getval endp
end