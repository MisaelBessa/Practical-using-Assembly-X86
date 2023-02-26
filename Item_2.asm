%include "io.inc"
section .data
extern _scanf
extern _printf

section .data
scanfFmt: db "%d %d %d %d %d", 0x00
printFmt: db "%d", 0x0d, 0x00
printS: db "media: ", 0x0d, 0x00

section .bss
Maria resd 1
Joao resd 1
Ana resd 1
Jose resd 1
Paula resd 1
media resd 1
;variáveis para guardar as notas de cada aluno

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    push ebp
    add esp, 4
  
    ;scanf("%d %d %d %d %d", &Paula, &Jose, &Ana, &Joao, &Maria);
    
    push Maria
    push Joao
    push Ana
    push Jose
    push Paula
    push scanfFmt
    call _scanf ; scaneia as notas de cada aluno
    add esp, 24 ; adiciona o valor na pilha pra liberar
    
    mov eax, dword[Maria]
    mov ebx, dword[Joao]
    add eax, ebx
    mov ebx, dword[Ana]
    add eax, ebx
    mov ebx, dword[Jose]
    add eax, ebx
    mov ebx, dword[Paula]
    add eax, ebx ; soma todas as notas passo a passo colocando-as nos registores
    mov dword[media], eax ; guarda o resultado do calculo na variavel media
    
    mov eax, 0
    mov ebx, 0
    
    mov eax, dword[media]; move o valor que está em media para o eax
    mov bl, 5 ; move o valor 5 para a parte baixa de ebx = bl
    div bl ; divide o valor que está em eax pelo valor que está em bl
    mov ebx, eax ; move para ebx o valor que está em eax
    
    ; Exibir "media: "
    push printS
    call _printf
    add esp, 4
    
    ; Exibir o valor do quociente
    mov ah, 0 ; zera a parte alta que recebe o resto
    movzx eax, al ; Copia o conteúdo de al para eax e estende o valor. (0008)->(00000008)- operand size
    push eax ; empilha eax
    push printFmt
    call _printf
    add esp, 8
    
    ; Exibir o valor do resto
    mov eax, ebx ; zera eax
    mov al, 0 ; zera a parte baixa de eax que recebe o quociente
    movzx eax, ah ; move o valor da parte alta para eax
    push eax ; empilha eax para printar
    push printFmt
    call _printf
    add esp, 8
    
    xor eax, eax
    ret