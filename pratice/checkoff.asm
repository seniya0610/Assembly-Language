include Irvine32.inc

.data
arr dword -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5
count = 11
msg db "Odd numbers (using IDIV): ", 0

.code
main proc
    mov edx, offset msg
    call WriteString
    
    mov ecx, count
    mov esi, 0
    
print_loop:
    mov eax, arr[esi * 4]  ; Get number
    
    ; Use IDIV for signed numbers
    mov ebx, 2
    cdq                    ; Sign-extend EAX into EDX:EAX
    idiv ebx               ; EAX = quotient, EDX = remainder
    
    ; Check if remainder is NOT 0 (odd number)
    cmp edx, 0
    je even_num
    
    ; Display original odd number
    mov eax, arr[esi * 4]
    call WriteInt          ; Use WriteInt for signed numbers
    mov al, ' '
    call WriteChar
    
even_num:
    inc esi
    loop print_loop
    
    call Crlf
    exit
main endp
end main
