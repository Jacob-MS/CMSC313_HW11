section .data
    inputBuf db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    inputLen dd 8
    table db "0123456789ABCDEF"                 ; table storing hex characters

section .bss
    outputBuf resb 80

section .text
    global _start

_start:
    xor     ecx, ecx                            ; index, used to iterate through inputBuf

translate:                                      ; loops through the input buffer and translates the data
    cmp     ecx, [inputLen]                     ; loops until ecx reaches the input buffer length 
    jge     print                               ; goes to the print section after all the data is translated, (ecx >= 8)

    mov     al, [inputBuf + ecx]                ; move the byte of data from inputBuf at the index into al register

    ; translate the first nibble (4 bits)
    mov     ah, al                  
    shr     ah, 4                               ; isolate the first nibble
    movzx   ebx, ah                             ; stores byte in ebx with the proper bit amount, ebx will be used as an index for the hex table
    mov     dl, [table + ebx]                   ; store the hex character of the first nibble
    mov     [outputBuf + ecx*3], dl             ; store the character in the output buffer

    ; translate the second nibble (4 bits)
    and     al, 0x0F                            ; isolates the second nibble, 0x0F = 00001111 so the first 4 bits of al are set to 0 and the bottom 4 are preserved
    movzx   ebx, al                             ; stores byte in ebx with the proper bit amount, ebx will be used as an index for the hex table
    mov     dl, [table + ebx]                   ; store the hex character of the first nibble
    mov     [outputBuf + ecx*3 + 1], dl         ; store the character in the output buffer

    ; store a space 
    mov     byte [outputBuf + ecx*3 + 2], ' '   ; needed for formatting the output

    inc ecx                 
    jmp translate                               ; reinitiate loop

print:
    mov     byte [outputBuf + ecx*3 - 1], 0x0A  ; replace the final space of the output with a newline character
    
    mov     edx, [inputLen]                     ; store the length of the input to print
    imul    edx, 3                              ; multiply by 3 to get the amount of characters (bytes) total in the output buffer

    ; print output
    mov     eax, 4                              ; sys_write
    mov     ebx, 1                              ; stdout      
    mov     ecx, outputBuf                      ; we want to print the output buffer
    int     0x80

    ; exit program
    mov     eax, 1
    xor     ebx, ebx
    int     0x80
