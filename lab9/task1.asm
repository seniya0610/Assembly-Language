include Irvine32.inc

.data

prompt1 byte "enter grade: ", 0
prompt2 byte "enter size: ", 0
passcount dword 0
grades dword 10 dup(0)
prompt3 byte "grades",0
prompt4 byte "passed student count: ",0
errormsg byte "wrong input", 0

.code
main proc

mov edx, offset prompt2
call writestring
call readint
mov ecx, eax
mov eax, 0
mov esi, offset grades

looper:
something:
	mov edx, offset prompt1
	call writestring
	call readint
	
	mov [esi], eax
	cmp dword ptr [esi], 0
	jl invalid
	cmp dword ptr [esi], 100
	jg invalid

	cmp dword ptr [esi], 50
	jge incrementcount
	jmp nextnum

	incrementcount:
	inc passcount
	jmp nextnum

	invalid:
	mov edx, offset errormsg
	call writestring
	call crlf
	jmp something

	nextnum:
	add esi, type grades
	loop looper

mov esi, offset grades
mov edx, offset prompt3
call writestring
call crlf
mov ecx, 10

looper2:
mov eax, [esi]
call writeint
mov al, " "
call writechar
add esi, type grades
loop looper2
call crlf
mov edx, offset prompt4
call writestring
mov eax, passcount
call writeint
call crlf

exit
main endp
end main
