#!/bin/sh
# Script de Instalação Universal do FPS (Fins Educacionais)
set -e

# Cores para o terminal para dar um visual limpo
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CLEAR='\033[0m'

echo "${BLUE}=====================================================${CLEAR}"
echo "       Instalador Automatizado do FPS v0.8.6"
echo "${BLUE}=====================================================${CLEAR}"

# URL direta de onde o script vai puxar o binário compilado do FPS
BIN_URL="https://raw.githubusercontent.com/Rodriguezzs/FPS---Repository/bin/fps"

# Identifica o nível de privilégio do usuário
if [ "$(id -u)" -eq 0 ]; then
    echo "[FPS] Modo detectado: GLOBAL (Instalação no Sistema)"
    TARGET_DIR="/usr/local/bin"
    # Pré-cria o diretório global de repositórios do FPS
    mkdir -p /etc/fps/repos.d
else
    echo "[FPS] Modo detectado: PORTÁTIL (Instalação na Home)"
    TARGET_DIR="$HOME/.local/bin"
    # Pré-cria a estrutura interna portátil do FPS para o usuário comum
    mkdir -p "$HOME/.local/share/fps/root"
    mkdir -p "$HOME/.config/fps/repos.d"
fi

# Garante que a pasta de destino do binário exista
mkdir -p "$TARGET_DIR"

echo "[FPS] Baixando binário estático do repositório GitHub..."
if ! curl -sL "$BIN_URL" -o "$TARGET_DIR/fps"; then
    echo "Erro: Não foi possível baixar o binário. Verifique sua conexão ou se o arquivo 'fps' está na raiz do seu repositório."
    exit 1
fi

echo "[FPS] Aplicando permissões de execução (chmod +x)..."
chmod +x "$TARGET_DIR/fps"

echo "${GREEN}[✓] FPS instalado com sucesso em: $TARGET_DIR/fps${CLEAR}"

# Inicializa as tabelas locais rodando uma chamada rápida
echo "[FPS] Inicializando banco de dados de metadados padrão..."
if [ "$(id -u)" -ne 0 ]; then
    # Se for usuário comum, roda o init para tentar injetar no .bashrc/.zshrc se necessário
    "$TARGET_DIR/fps" init
else
    # Se for root, apenas aciona uma leitura simples para gerar o oficial.json inicial em /etc
    "$TARGET_DIR/fps" repo list > /dev/null
fi

echo "${YELLOW}\nPronto! Teste o gerenciador executando: fps help${CLEAR}"
echo "${BLUE}=====================================================${CLEAR}"
