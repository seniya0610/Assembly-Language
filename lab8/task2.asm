INCLUDE Irvine32.inc

.data

enternum byte "enter number: ", 0
  
.code
main proc

    mov ecx, 5

looper:
    mov edx, offset enternum
    call writestring
    call readint
    push eax
loop looper

mov ecx,5 

looper2:
pop eax
call writeint
call crlf
loop looper2

    exit
main endp
end main
