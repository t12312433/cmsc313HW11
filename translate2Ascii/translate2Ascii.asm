section .data
inputBuf db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
totalSize equ 8

section .bss
outputBuf resb 80

section .text
global _start

_start:

	; Clears the registers
    xor ebx, ebx        
    xor edx, edx        

; Loops through every byte converting all the data
current8b_loop:

	; Checks if the for loop is done if it is jumps to the finish output
    cmp ebx, totalSize
    jge finish_ouput

	; Gets the current byte were working on
    mov al, [inputBuf + ebx] 

    ; Reads and converts the left four bits and increases the inner count
    mov cl, al
    shr cl, 4
    mov al, cl
    call byte_to_askii
    mov [outputBuf + edx], al
    inc edx

    ; Reads and converts the right four bits and increases inner count
    mov al, [inputBuf + ebx]
    and al, 0x0F
    call byte_to_askii
    mov [outputBuf + edx], al
    inc edx

    ; adds spaces for formatting and increases inner count
    mov byte [outputBuf + edx], ' '
    inc edx

	; Increments the outer loop count and restarts the loop
    inc ebx
    jmp current8b_loop

; Handles the final changes and formatting then prints and ends the program
finish_ouput:

	; Adds two newlines for formatting
    dec edx
    mov byte [outputBuf + edx], 0x0A
    inc edx
    mov byte [outputBuf + edx], 0x0A
    inc edx

    ; Prints the output buffer
    xor eax, eax        
    mov eax, 4         
    mov ebx, 1          
    mov ecx, outputBuf
    mov edx, edx        
    int 0x80

    ; Quits the assembly code
    mov     ebx, 0      
    mov     eax, 1      
    int     80h


; Converts the current byte to askki
byte_to_askii:

	; Checks if it's a letter in hex and jumps if so
    cmp al, 9
    jg letter_convert
	
	; Converts to the number and retruns
    add al, '0'
    ret

; Converts the current byte to the letter and returns
letter_convert:
    add al, 'A' - 10
    ret
