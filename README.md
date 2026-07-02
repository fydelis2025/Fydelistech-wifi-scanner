# 📡 FydelisTech Wireless Scanner

**Autor:** Adiel Santos Fontes  
**Objetivo:** Estudo acadêmico e prático de interação com o Kernel Linux para varredura de redes Wi-Fi (Interface `wlp3s0`).

Este repositório demonstra a evolução do desenvolvimento de ferramentas de rede, partindo da escovação de bits em baixo nível até soluções em linguagens de alto nível.

---

## 🚀 Tecnologias e Implementações

### 1. Assembly x86_64
* **Abordagem 1 (`ioctl`):** Manipulação direta de syscalls do sistema e buffers de memória para comunicação com o driver de rede.
* **Abordagem 2 (`execve`):** Otimização e robustez chamando o interpretador de comandos shell e aplicando filtros nativos (`grep`/`sed`).

### 2. Linguagem C
* Implementação eficiente utilizando sockets nativos e a biblioteca padrão do Linux para manipulação de estruturas de rede.

### 3. Python
* Versão em alto nível focada em portabilidade, facilidade de leitura e tratamento de dados.

---

## 🛠️ Como Executar

> ⚠️ **Nota:** Devido à natureza das operações de rede, todas as versões exigem privilégios de administrador (root).

### Executando a versão em Assembly:
```bash
nasm -f elf64 wifiok.asm -o wifiok.o
ld wifiok.o -o wifiok
sudo ./wifiok
