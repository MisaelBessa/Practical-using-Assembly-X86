%include "io.inc"

extern _scanf
extern _printf

section .data
scanfFmt: db "%d %d %d %d %d", 0x00
printFmt: db "%d", 0x0d, 0x00

printS: db "media:", 0x0d, 0x00

Maria1: db "Maria aprovada  ", 0x0d, 0x00
Maria2: db "Maria reprovada  ", 0x0d, 0x00

Joao1: db "Joao aprovado  ", 0x0d, 0x00
Joao2: db "Joao reprovado  ", 0x0d, 0x00

Ana1: db "Ana aprovada  ", 0x0d, 0x00
Ana2: db "Ana reprovada  ", 0x0d, 0x00

Jose1: db "Jose aprovado  ", 0x0d, 0x00
Jose2: db "Jose reprovado  ", 0x0d, 0x00

Paula1: db "Paula aprovada  ", 0x0d, 0x00
Paula2: db "Paula reprovada  ", 0x0d, 0x00
 
; cada tipo de print representa uma condição do aluno: Reprovado ou Aprovado
; Esses prints serão chamados caso os "ifs" e "elses"criados sejam executados

section .bss
Maria resd 1
Joao resd 1
Ana resd 1
Jose resd 1
Paula resd 1
media resd 1

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
    call _scanf
    add esp, 24
    
    
    f_maria: ;função para esta aluna... cada aluno terá sua própria função para ser chamado nos condicionais
        cmp dword[Maria], 7 
        ; if(Maria => 7){aprovacao}
        jae aprovacaoMaria
        ; else{reprovacao}
        jb reprovacaoMaria
    
    
    f_joao:;função para este aluno... cada aluno terá sua própria função para ser chamado nos condicionais
        cmp dword[Joao], 7
        ; if(Joao => 7){aprovacao}
        jae aprovacaoJoao
        ; else{reprovacao}
        jb reprovacaoJoao
    
    
    f_ana:;função para esta aluna... cada aluno terá sua própria função para ser chamado nos condicionais
        cmp dword[Ana], 7
        ; if(Ana => 7){aprovacao}
        jae aprovacaoAna
        ; else{reprovacao}
        jb reprovacaoAna
    
    
    f_jose:;função para este aluno... cada aluno terá sua própria função para ser chamado nos condicionais
        cmp dword[Jose], 7
        ; if(Jose => 7){aprovacao}
        jae aprovacaoJose
        ; else{reprovacao}
        jb reprovacaoJose
    
    
    f_paula:;função para esta aluna... cada aluno terá sua própria função para ser chamado nos condicionais
        ; if(Paula => 7){aprovacao}
        cmp dword[Paula], 7
        jae aprovacaoPaula
        ; else{reprovacao}
        jb reprovacaoPaula
    
    
    f_media:;função para o cálculo da média, mesmo utilizado no item 2 da prática
        
        ; exibir "media:"
        push printS
        call _printf
        add esp, 4
        
        mov eax, dword[Maria]
        mov ebx, dword[Joao]
        add eax, ebx
        mov ebx, dword[Ana]
        add eax, ebx
        mov ebx, dword[Jose]
        add eax, ebx
        mov ebx, dword[Paula]
        add eax, ebx
        mov dword[media], eax
        
        mov eax, 0
        mov ebx, 0
        
        mov eax, dword[media]
        mov bl, 5
        div bl
        mov ebx, eax
        
        
        
        ; Exibir o valor do quociente
        mov ah, 0
        movzx eax, al
        push eax
        push printFmt
        call _printf
        add esp, 8
        
        ; Exibir o valor do resto
        mov eax, ebx
        mov al, 0
        movzx eax, ah
        push eax
        push printFmt
        call _printf
        add esp, 8
    
    
    xor eax, eax
    ret
    
aprovacaoMaria:; função dedicada para printar aprovação deste aluno
    push Maria1
    call _printf
    add esp, 4
    jmp f_joao

reprovacaoMaria:; função dedicada para printar reprovação deste aluno
    push Maria2
    call _printf
    add esp, 4
    jmp f_joao

aprovacaoJoao:; função dedicada para printar aprovação deste aluno
    push Joao1
    call _printf
    add esp, 4 
    jmp f_ana
reprovacaoJoao:; função dedicada para printar reprovação deste aluno
    push Joao2
    call _printf
    add esp, 4
    jmp f_ana

aprovacaoAna:; função dedicada para printar aprovação deste aluno
    push Ana1
    call _printf
    add esp, 4  
    jmp f_jose  
reprovacaoAna:; função dedicada para printar reprovação deste aluno
    push Ana2
    call _printf 
    add esp, 4
    jmp f_jose   

aprovacaoJose:; função dedicada para printar aprovação deste aluno
    push Jose1
    call _printf
    add esp, 4   
    jmp f_paula 
reprovacaoJose:; função dedicada para printar reprovação deste aluno
    push Jose2
    call _printf 
    add esp, 4  
    jmp f_paula 
    
aprovacaoPaula:; função dedicada para printar aprovação deste aluno
    push Paula1
    call _printf
    add esp, 4
    jmp f_media
reprovacaoPaula:; função dedicada para printar reprovação deste aluno
    push Paula2
    call _printf 
    add esp, 4  
    jmp f_media
    


