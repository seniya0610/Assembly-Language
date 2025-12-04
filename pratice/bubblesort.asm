INCLUDE Irvine32.inc

BubbleSort PROTO pArray:PTR DWORD, Count:DWORD

.data
myArray DWORD 23, 5, 89, 12, 7, 34, 1, 56, 10, 42
arraySize DWORD LENGTHOF myArray
newlineStr BYTE 0Dh, 0Ah, 0

.code
main PROC
    mov esi, OFFSET myArray
    mov ecx, arraySize
    call PrintArray
    
    INVOKE BubbleSort, ADDR myArray, arraySize
    
    mov esi, OFFSET myArray
    mov ecx, arraySize
    call PrintArray
    
    exit
main ENDP

BubbleSort PROC USES eax ebx ecx esi edi,
    pArray:PTR DWORD,    ; pointer to array
    Count:DWORD          ; array size

    mov   ecx, Count
    dec   ecx                 ; outer loop counter (n-1)
    jle   L4                  ; exit if 1 or fewer elements
    
OuterLoop:
    mov   ebx, 0              ; swap flag = false (0)
    mov   esi, pArray         ; point to first value
    push  ecx                 ; save outer loop count
    
InnerLoop:
    mov   eax, [esi]          ; get current value
    mov   edx, [esi+4]        ; get next value
    
    cmp   eax, edx            ; compare a pair of values
    jle   NoSwap              ; if [ESI] <= [ESI+4], no exchange
    
    ; Exchange the pair
    mov   [esi], edx
    mov   [esi+4], eax
    mov   ebx, 1              ; set swap flag = true (1)
    
NoSwap:
    add   esi, 4              ; move pointer forward
    loop  InnerLoop           ; inner loop
    
    pop   ecx                 ; retrieve outer loop count
    
    ; Check if any swaps occurred
    cmp   ebx, 0
    je    L4                  ; if no swaps, array is sorted
    
    loop  OuterLoop           ; else repeat outer loop
    
L4:
    ret
BubbleSort ENDP

PrintArray PROC USES eax ecx esi
    cmp   ecx, 0
    je    PrintDone
    
PrintLoop:
    mov   eax, [esi]
    call  WriteInt
    mov   edx, OFFSET newlineStr
    call  WriteString
    add   esi, 4
    loop  PrintLoop
    
PrintDone:
    call  Crlf
    ret
PrintArray ENDP

END main
