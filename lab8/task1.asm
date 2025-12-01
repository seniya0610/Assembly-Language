INCLUDE Irvine32.inc

.data

negE byte "negative: ", 0
pos byte "positive: ", 0
zer byte "zero: ", 0
enternum byte "enter number: ", 0

countN DWORD 0
countP DWORD 0
countZ DWORD 0

.code
main proc

    mov ecx, 5

looper:
    mov edx, offset enternum
    call writestring
    call readint

    cmp eax, 0
    jg positiveblock
    jl negativeblock
    
    ; If EAX == 0
    inc countZ
    jmp nextl

negativeblock:
    inc countN
    jmp nextl

positiveblock:
    inc countP
    jmp nextl

nextl:
    loop looper

    mov edx, offset negE
    call writestring
    mov eax, countN
    call writeint
    call crlf

    mov edx, offset pos
    call writestring
    mov eax, countP
    call writeint
    call crlf

    mov edx, offset zer
    call writestring
    mov eax, countZ
    call writeint
    call crlf

    exit
main endp
end main
