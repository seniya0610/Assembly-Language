include Irvine32.inc
.data
inputstr byte "I like Assembly programming. Assembly is powerful.", 0
substring byte "Assembly", 0
replacement byte "ASM", 0
outputbuffer byte 1000 dup(0)  ; Buffer for output
msg_original byte "Original: ", 0
msg_modified byte "Modified: ", 0

findLen dword 0
replaceLen dword 0

.code
main proc
    ; Display original string
    mov edx, offset msg_original
    call WriteString
    mov edx, offset inputstr
    call WriteString
    call Crlf
    
    invoke str_ucase, addr inputstr
    invoke str_ucase, addr substring    ; Fixed: added "addr"
    
    invoke Str_length, addr substring
    mov findLen, eax
    
    invoke Str_length, addr replacement
    mov replaceLen, eax
    
    mov esi, offset inputstr
    mov edi, offset outputbuffer

mainloop:
    mov al, [esi]
    cmp al, 0
    je end_of_string
    
    mov ebx, offset substring
    cmp al, [ebx]
    jne addtobuffer
    
    ; Possible match - check rest of substring
    push esi        ; Save current position
    push edi
    
    mov ecx, findLen
    dec ecx
    
check_rest:
    cmp ecx, 0
    je found_match
    
    inc esi
    inc ebx
    mov al, [esi]
    mov ah, [ebx]
    cmp al, ah
    jne not_match
    
    dec ecx
    jmp check_rest
    
found_match:
    ; Restore pointers
    pop edi
    pop esi         ; ESI points to start of match
    
    ; Copy replacement to output
    mov ecx, replaceLen
    mov ebx, offset replacement
    
copy_replace:
    mov al, [ebx]
    mov [edi], al
    inc ebx
    inc edi
    loop copy_replace
    
    add esi, findLen
    jmp mainloop
    
not_match:
    pop edi
    pop esi
    
addtobuffer:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    jmp mainloop

end_of_string:
    mov byte ptr [edi], 0
    
    ; Display result
    mov edx, offset msg_modified
    call WriteString
    mov edx, offset outputbuffer
    call WriteString
    call Crlf
    
    exit
main endp
end main
