INCLUDE Irvine32.inc

.data

enternum byte "enter number: ", 0
arr DWORD 5 DUP(0)
big DWORD ?
small DWORD ?
msgbig byte "Biggest: ", 0 ; Added colon and null terminator for clean output
msgsmall byte "Smallest: ", 0 ; Added colon and null terminator for clean output

.code
main proc

    ; --- Input Loop: Read and Store 5 numbers ---

    mov esi, OFFSET arr
    mov ecx, 5
    call crlf

looper:
    mov edx, OFFSET enternum
    call WriteString
    call ReadInt
    mov [esi], eax
    add esi, TYPE arr
loop looper

    ; --- Initialization ---
    
    mov esi, OFFSET arr
    mov eax, [esi]
    mov big, eax
    mov small, eax
    add esi, TYPE arr
    mov ecx, 4 ; Loop count for the remaining 4 elements
    call crlf

    ; --- Find Biggest Loop ---

bigger:
    mov eax, [esi]
    cmp eax, big
    jg change1
    jmp else1

change1:
    mov big, eax

else1:
    add esi, TYPE arr
loop bigger

    
    mov esi, OFFSET arr 
    add esi, TYPE arr 

    mov ecx, 4

smaller:
    mov eax, [esi]
    cmp eax, small
    jl change2
    jmp else2

change2:
    mov small, eax

else2:
    add esi, TYPE arr
loop smaller 

    mov edx, OFFSET msgbig
    call WriteString
    mov eax, big
    call WriteInt
    call crlf

    mov edx, OFFSET msgsmall
    call WriteString
    mov eax, small
    call WriteInt
    call crlf

    exit
main endp
end main
