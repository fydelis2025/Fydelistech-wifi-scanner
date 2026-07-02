; =====================================================================
;  FydelisTech Wi-Fi Scanner
;  Autor: Adiel Santos Fontes
; =====================================================================

section .data
    cmd  db "/bin/sh", 0
    arg1 db "-c", 0
    
    ; Embutimos o "Fim das buscas" direto no pipeline do shell para garantir que apareça após os resultados
    arg2 db "echo 'Rastreando as redes disponíveis...'; iw dev wlp3s0 scan | grep 'SSID:' | sed 's/.*SSID: //'; echo -e '\n[+] Fim das buscas.'", 0
    args dq cmd, arg1, arg2, 0
    env  dq 0

    ; --- Identidade Visual (Banner) ---
    banner db "==================================================", 0xA
           db "               FYDELISTECH WIRELESS               ", 0xA
           db "          Autor: Adiel Santos Fontes              ", 0xA
           db "==================================================", 0xA, 0xA
    len_banner equ $ - banner

    ; --- Mensagem de Alerta (Root) ---
    msg_root db "[!] Erro: Privilégios insuficientes.", 0xA
             db "[*] Execute como ROOT usando: sudo ./scan_wifi", 0xA
    len_root equ $ - msg_root

section .text
    global _start

_start:
    ; 1. Exibir o Banner Profissional da FydelisTech
    mov rax, 1          ; syscall 1 = sys_write
    mov rdi, 1          ; stdout
    lea rsi, [banner]   ; ponteiro para o banner
    mov rdx, len_banner ; tamanho
    syscall

    ; 2. Tentar executar o scanner de redes
    mov rax, 59         ; syscall 59 = sys_execve
    lea rdi, [cmd]
    lea rsi, [args]
    lea rdx, [env]
    syscall

    ; --- Se chegar aqui, o execve FALHOU (Provavelmente falta de sudo) ---
    cmp rax, -1
    je  .aviso_root
    cmp rax, -13
    je  .aviso_root
    jmp sys_exit

.aviso_root:
    ; Exibir o aviso de necessidade de root personalizado
    mov rax, 1
    mov rdi, 1
    lea rsi, [msg_root]
    mov rdx, len_root
    syscall

sys_exit:
    mov rax, 60         ; syscall 60 = sys_exit
    mov rdi, 1          ; código de saída indicando erro
    syscall
