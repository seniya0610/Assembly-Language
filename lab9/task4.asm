include Irvine32.inc
.data
prompt1 byte "enter reading: ", 0
readings dword 10 dup(?)
sumofR dword 0
errmsg byte "invalid input: ", 0
summsg byte "sum: ", 0
avgmsg byte "Average: ", 0
average dword 0

.code
main proc
    mov ecx, lengthof readings
    mov esi, offset readings
    mov ebx, 0

inputloop:
validationcheck:
    mov edx, offset prompt1
    call writestring
    call readint

    cmp eax, 0
    jl invalid

    mov [esi], eax
    add ebx, eax
    jmp nextin

invalid:
    mov edx, offset errmsg
    call writestring
    call crlf
    jmp validationcheck

nextin:
    add esi, type readings
    loop inputloop

    mov sumofR, ebx
    
    mov eax, sumofR
    cdq
    mov ecx, lengthof readings
    div ecx
    mov average, eax

    mov edx, offset summsg
    call writestring
    mov eax, sumofR
    call writeint
    call crlf

    mov edx, offset avgmsg
    call writestring
    mov eax, average
    call writeint
    call crlf

    exit
main endp
end main
