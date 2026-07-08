#!/bin/sh
# Script de Instalação Universal do FPS (Fins Educacionais)
set -e

# Cores para o terminal para dar um visual limpo
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CLEAR='\033[0m'

printf "${BLUE}=====================================================${CLEAR}\n"
printf "       Instalador Automatizado do FPS v0.8.6\n"
printf "${BLUE}=====================================================${CLEAR}\n"

# URL direta de onde o script vai puxar o binário compilado do FPS
BIN_URL="https://github.com/Rodriguezzs/FPS---Repository/raw/refs/heads/main/bin/fps"

# Identifica o nível de privilégio do usuário
if [ "$(id -u)" -eq 0 ]; then
    echo "[FPS] Modo detectado: GLOBAL (Instalação no Sistema)"
    TARGET_DIR="/usr/bin/"
    mkdir -p /etc/fps/repos.d
else
    echo "[FPS] Modo detectado: PORTÁTIL (Instalação na Home)"
    TARGET_DIR="$HOME/.local/bin"
    mkdir -p "$HOME/.local/share/fps/root"
    mkdir -p "$HOME/.config/fps/repos.d"
fi

# Garante que a pasta de destino do binário exista
mkdir -p "$TARGET_DIR"

echo "[FPS] Baixando binário estático do repositório GitHub..."
# A flag -fsSL impede que páginas de erro 404 corrompam o binário de saída
if ! curl -fsSL "$BIN_URL" -o "$TARGET_DIR/fps"; then
    echo "Erro: Não foi possível baixar o binário. Verifique sua conexão ou se o arquivo 'fps' está correto na raiz do repositório."
    exit 1
fi

echo "[FPS] Aplicando permissões de execução (chmod +x)..."
chmod +x "$TARGET_DIR/fps"

printf "${GREEN}[✓] FPS instalado com sucesso em: $TARGET_DIRfps${CLEAR}\n"

# Inicializa as tabelas locais rodando uma chamada rápida
echo "[FPS] Inicializando banco de dados de metadados padrão..."
if [ "$(id -u)" -ne 0 ]; then
    # Executa o init para configurar o terminal ativo (.bashrc, .zshrc ou config.fish)
    "$TARGET_DIR/fps" init
else
    "$TARGET_DIR/fps" repo list > /dev/null
fi

printf "${YELLOW}\nPronto! Teste o gerenciador executando: fps help${CLEAR}\n"
printf "${BLUE}=====================================================${CLEAR}\n"
