# 🚀 Flexible Package System (FPS)

[![Go Version](https://img.shields.shields.shields.shields.shields.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://go.dev/)
[![Linux Compatible](https://img.shields.shields.shields.shields.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![Academic Project](https://img.shields.shields.shields.shields.shields.io/badge/Purpose-Educational-blue?style=for-the-badge)](https://github.com/Rodriguezzs/FPS---Repository)

O **FPS (Flexible Package System)** é um gerenciador de pacotes leve, descentralizado e focado em portabilidade, desenvolvido em **Go** para sistemas operacionais baseados em Linux (incluindo distribuições como Gentoo, LFS e ambientes portáteis).

Este repositório atua como o **servidor oficial de metadados e distribuição de binários** para a árvore de softwares do FPS.

---

## ✨ O que há de novo na v0.9.9?

* **Operações em Lote Verdadeiras:** Instalação, reinstalação e remoção de múltiplos pacotes passados como argumento em uma única chamada.
* **Resumo de Transação Consolidado:** Assim como o *DNF* e o *Pacman*, o FPS agora monta a árvore completa de dependências e exibe uma tabela clara com todos os pacotes afetados no terminal, aguardando uma única confirmação do usuário `[S/n]` antes de tocar no disco.
* **Mecanismo de Lockfile Centralizado:** Criação automática do arquivo temporário `fps.lock` para prevenir colisões na base de dados ou arquivos corrompidos se o usuário disparar duas instâncias do gerenciador simultaneamente.
* **Sistema Avançado de Rollback Transacional:** Caso ocorra uma interrupção abrupta (queda de conexão, falta de espaço ou erro de leitura do tarball) durante a extração de um pacote, o FPS desfaz a operação e apaga automaticamente todos os arquivos parciais gerados por aquele pacote.
* **Proteção de Configurações no `/etc`:** Se o pacote contiver um arquivo de configuração voltado para `/etc` que já exista localmente, o FPS não o destrói; ele o extrai sob a extensão `.fpsnew` para preservar suas customizações.
* **Prevenção contra Colisão Crítica de Arquivos:** O FPS inspeciona os metadados e o conteúdo antes da escrita para garantir que nenhum pacote tente roubar ou sobrescrever binários pertencentes a outro software já instalado.

---

## 🛠️ Arquitetura e Escopo Automatizado (Dual-Core)

O FPS detecta automaticamente os níveis de privilégio do usuário no momento da chamada para chavear seu ecossistema estrutural:

### 1. Escopo Global (Root / `sudo`)
* **Raiz Operacional (RootSys):** `/`
* **Base de Dados de Registro:** `/var/lib/fps/installed`
* **Cache de Downloads e Locks:** `/var/cache/fps`
* **Configuração de Espelhos (Repos):** `/etc/fps/repos.d`
* **Histórico de Logs:** `/var/log/fps`

### 2. Escopo Portátil (Rootless / Usuário Comum)
* **Raiz Operacional (RootSys):** `~/.local/share/fps/root`
* **Base de Dados de Registro:** `~/.local/share/fps/installed`
* **Cache de Downloads e Locks:** `~/.cache/fps`
* **Configuração de Espelhos (Repos):** `~/.config/fps/repos.d`
* **Histórico de Logs:** `~/.local/state/fps/log`

---

## 💻 Guia Prático de Comandos

### Gerenciamento Principal de Softwares (Lote)
```bash
# Sincroniza a árvore de metadados locais com todos os servidores ativos
fps update

# Instala um ou mais softwares resolvendo suas dependências em lote automaticamente
fps install nano htop neovim

# Força a reinstalação de múltiplos pacotes em uma única transação
fps reinstall nano python3

# Remove múltiplos pacotes limpando seus rastros e respeitando ganchos pré-remoção
fps remove nano htop

# Analisa e executa o upgrade geral de todos os softwares desatualizados no sistema
fps dist-upgrade
---

## 💾 Instalação Rápida (Universal via curl)

Para instalar o FPS na sua máquina de forma totalmente automatizada através deste repositório, execute o comando correspondente no seu terminal Linux:

### 👤 Usuário Comum (Instalação Portátil na Home)
Instala o binário em `~/.local/bin` e configura as variáveis de ambiente automaticamente:
```bash
curl -sSL https://raw.githubusercontent.com/Rodriguezzs/FPS---Repository/main/scripts/install.sh | sh
