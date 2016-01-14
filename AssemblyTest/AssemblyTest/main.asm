ExitProcess PROTO

.data
	qword1 qword 12345678ffeeddcch

.code
	
;'main' is our designated linker
main proc	;start process main
	mov rax, 2c5h	;move information to specified registry
	mov rbx, qword1
	mov rcx, 1

	call ExitProcess
main endp	;end process main
end