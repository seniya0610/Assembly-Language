include Irvine32.inc

.data
prompt1 byte "Enter first number: ", 0
prompt2 byte "Enter second number: ", 0
resultMsg byte "Product = ", 0
num1 dword 0
num2 dword 0
product dword 0

.code
main proc
    ; Get first number
    mov edx, offset prompt1
    call writestring
    call readint
    mov num1, eax      ; Multiplicand
    call crlf
    
    ; Get second number
    mov edx, offset prompt2
    call writestring
    call readint
    mov num2, eax      ; Multiplier
    call crlf
    
    ; Initialize registers
    mov eax, 0          ; Accumulator for result
    mov ebx, num1       ; Multiplicand in ebx
    mov ecx, num2       ; Multiplier in ecx
    mov edx, 0          ; Clear edx
    
    ; Bitwise multiplication algorithm
    ; while (multiplier != 0)
    ;   if (multiplier & 1)
    ;       result += multiplicand
    ;   multiplicand <<= 1
    ;   multiplier >>= 1
    
multiply_loop:
    cmp ecx, 0          ; Check if multiplier is 0
    je done             ; If yes, we're done
    
    test ecx, 1         ; Check LSB of multiplier
    jz shift_only       ; If 0, skip addition
    
    ; Add multiplicand to result
    add eax, ebx        ; result += multiplicand
    
shift_only:
    shl ebx, 1          ; multiplicand <<= 1 (double it)
    shr ecx, 1          ; multiplier >>= 1 (move to next bit)
    
    jmp multiply_loop

done:
    mov product, eax
    mov edx, offset resultMsg
    call writestring
    call writeint   
    call crlf
    
    exit
main endp
end main
