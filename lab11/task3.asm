include Irvine32.inc
.data

string byte "this is a very important string hehe <3", 0
successstring byte "this is the string input: ", 0
buffer byte 50 dup(?)
len dword 0

.code
main proc

mov esi, offset string
mov edi, offset buffer
mov ebx, 0

cld

l1:
lodsb ;esi->eax
cmp al, 0
je done
inc ebx
jmp l1

done:
mov ecx, ebx
mov esi, offset string

rep movsb

mov edx, offset successstring
call writestring
mov edi, offset buffer
mov edx, edi
call writestring

exit
main endp
end main
