include Irvine32.inc
.data

prompt1 byte "enter number: ", 0
outro byte "answer: ", 0
answer dword 0

.code
main proc

mov edx, offset prompt1
call writestring
call readint
call crlf

cmp eax, 0
je display

cmp eax, 1
je display

mov ecx, eax
mov eax, 1

looper:
imul eax, ecx
loop looper

mov answer, eax

display:
mov edx, offset outro
call writestring
call writeint
call crlf

exit
main endp
end main
