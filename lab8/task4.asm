INCLUDE Irvine32.inc

.data

prompt1         BYTE "enter word: ", 0
inputBuffer     BYTE 51 DUP(?) 
len             DWORD 0
vowel_msg       BYTE "Vowels: ", 0
consonant_msg   BYTE "Consonants: ", 0
vowel_count     DWORD 0
consonant_count DWORD 0
vowels          BYTE "AEIOU", 0

.code
main proc

    mov edx, OFFSET prompt1
    call WriteString
    
    mov edx, OFFSET inputBuffer
    mov ecx, SIZEOF inputBuffer
    call ReadString
    
    mov len, EAX
    mov ecx, EAX
    
    mov esi, OFFSET inputBuffer

    cmp ecx, 0
    je displayResult

checker:
    
    mov al, BYTE PTR [esi]

	cmp al, 'a'
	jl skip_conversion
	
	cmp al, 'z'
	jg skip_conversion

	sub al, 32

skip_conversion:
    
	mov edi, offset vowels
	
vowelSearch:
    cmp BYTE PTR [edi], 0
    je check_consonant

	cmp al, [edi]
	je incraseVowelCount
	
    inc edi
	jmp vowelSearch
    
check_consonant:
	cmp al, 'A'
	jl next_char
	cmp al, 'Z'
	jg next_char

    inc consonant_count
	jmp next_char

incraseVowelCount:
	inc vowel_count
    jmp next_char

next_char:
    inc esi
loop checker

displayResult:
    call Crlf
    
    mov edx, OFFSET vowel_msg
    call WriteString
    mov eax, vowel_count
    call WriteInt
    call CrLf
    
    mov edx, OFFSET consonant_msg
    call WriteString
    mov eax, consonant_count
    call WriteInt
    call CrLf
    
    exit
main endp
end main
