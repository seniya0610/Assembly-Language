include Irvine32.inc
.data

prompt1 byte "enter number: ", 0
num1 dword 0
prompt2 byte "encrypted: ", 0

.code
main proc

mov edx, offset prompt1
call writestring
call readint
mov num1, eax
call crlf

rol eax, 2
shr eax, 1

mov edx, offset prompt2
call writestring
call writeint
call crlf

exit
main endp
end main
