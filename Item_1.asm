%include "io.inc"
extern _scanf
extern _printf

section .data
scanfFmt: db "%d %d %d", 0x00
printFmt: db "%d", 0x0d, 0x00
printS: db "Salario", 0x0d, 0x00 ; printa a string "salario"

section .bss
valor resd 1 ; guarda o valor
comissao resd 1 ; guarda a comissao
diaria resd 1 ; guarda a diaria
s resd 1 ; guarda os valores que forem sendo acrescentados no decorrer do código até o valor final

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    push ebp
    add esp,4
    ;scanf("%d %d %d",&valor,&comissao,&diaria)
    push diaria
    push comissao
    push valor
    push scanfFmt
    call _scanf
    add esp, 16


    ;soma valor + comissao 
    push printS
    call _printf
    add esp, 4
    mov eax, dword[valor]
    mov ebx, dword[comissao]
    add eax, ebx ; soma os valores do valor e comissão
    mov dword[s], eax ; move para a variavel s os valores anteriormente somados
    add 200, 100
    ;soma valor + comissao + (diaria*7)
    mov eax, 7
    mul dword[diaria] ; multiplica a diarai vezes 7
    mov ebx, dword[s]
    add eax, ebx ; soma os valores que está em s com o resultado da multiplicação da diaria vezes 7
    mov dword[s], eax ; move para a variavel s os valores anteriormente somados
   
    ;soma valor + comissao + (diaria*7) - (3*valor)
    mov eax, 3
    mul dword[valor] ; multiplica o valor da variavel valor vezes 3
    mov ebx, dword[s]
    sub ebx, eax ; subtrai o resultado da multiplicação anterior com o valor de s até o momento
    mov dword[s], ebx ; move para a variavel s os valores anteriormente calculados

    push dword[s] ; empilha o valor de s
    push printFmt ; empilha a função de print
    call _printf ; chama a função _printf
    add esp, 8 ; adiciona valor 8 na pilha pois foram 2 push = 4 bytes cada

    xor eax, eax
    ret
