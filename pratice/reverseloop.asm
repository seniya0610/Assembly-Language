INCLUDE Irvine32.inc

.data

enternum byte "enter number: ", 0
arr dword 5 dup(0)

.code
main proc

mov esi, offset arr
mov ecx, 5
call crlf

looper:
    mov edx, offset enternum
    call writestring
    call readint
    
    mov[esi], eax
    add esi, type arr
loop looper

mov esi, offset arr
add esi, 16             ;come to the start of the 5th element
mov ecx, 5

looper2
mov eax, [esi]
call writeint
call crlf
sub esi, type arr

loop looper2

    exit
main endp
end main
