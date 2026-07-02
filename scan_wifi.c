/*
=====================================================================
  FydelisTech Wi-Fi Scanner
  Linguagem: C
  Autor: Adiel Santos Fontes
  Versão: Compatível com todos os kernels
=====================================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    // --- Banner ---
    printf("==================================================\n");
    printf("               FYDELISTECH WIRELESS               \n");
    printf("          Autor: Adiel Santos Fontes              \n");
    printf("==================================================\n\n");

    // --- Verificar root ---
    if (getuid() != 0) {
        printf("[!] Erro: Privilégios insuficientes.\n");
        printf("[*] Execute: sudo ./wifiok\n");
        return EXIT_FAILURE;
    }

    printf("[+] Rastreando as redes disponíveis...\n\n");

    // --- Mesmo comando confiável que usou no Assembly ---
    // Usamos popen para capturar e exibir a saída corretamente
    FILE *fp = popen("iw dev wlp3s0 scan 2>/dev/null | grep 'SSID:' | sed 's/.*SSID: //'", "r");
    if (!fp) {
        printf("[!] Falha ao iniciar varredura.\n");
        return EXIT_FAILURE;
    }

    char linha[256];
    while (fgets(linha, sizeof(linha), fp) != NULL) {
        printf("📶 %s", linha);
    }

    pclose(fp);

    printf("\n[+] Fim das buscas.\n");
    return EXIT_SUCCESS;
}
