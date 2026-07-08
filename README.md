# 🚀 Flexible Package System (FPS)

[![Go Version](https://img.shields.shields.shields.shields.shields.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://go.dev/)
[![Linux Compatible](https://img.shields.shields.shields.shields.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![Academic Project](https://img.shields.shields.shields.shields.shields.io/badge/Purpose-Educational-blue?style=for-the-badge)](https://github.com/Rodriguezzs/FPS---Repository)

O **FPS (Flexible Package System)** é um gerenciador de pacotes leve, descentralizado e focado em portabilidade, desenvolvido em **Go** para sistemas operacionais baseados em Linux (incluindo distribuições como Gentoo, LFS e ambientes portáteis).

Este repositório atua como o **servidor oficial de metadados e distribuição de binários** para a árvore de softwares do FPS.

---

## 🛠️ Recursos Atuais (v0.8.6)
* **Arquitetura Multi-Repositório**: Permite adicionar, listar e remover múltiplos servidores de software de forma dinâmica.
* **Resolução de Dependências com Trava de Segurança**: Se um pacote exigir dependências ausentes ou corrompidas, a transação é interrompida com segurança.
* **Modo Rootless Dinâmico**: Pode ser instalado globalmente (como Root) ou de forma 100% isolada e portátil dentro do diretório `$HOME` do usuário comum.
* **Sistema de Ajuda Paginado**: Interface CLI limpa e organizada em páginas para facilitar o uso.

---

## 💾 Instalação Rápida (Universal via curl)

Para instalar o FPS na sua máquina de forma totalmente automatizada através deste repositório, execute o comando correspondente no seu terminal Linux:

### 👤 Usuário Comum (Instalação Portátil na Home)
Instala o binário em `~/.local/bin` e configura as variáveis de ambiente automaticamente:
```bash
curl -sSL [https://raw.githubusercontent.com/Rodriguezzs/FPS---Repository/main/scripts/install.sh](https://raw.githubusercontent.com/Rodriguezzs/FPS---Repository/main/scripts/install.sh) | sh
