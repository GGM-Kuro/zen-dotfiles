#!/usr/bin/env bash
set -euo pipefail

CONFIG="symlink/conf.yaml"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${BASEDIR}/.venv"

echo "==> Comenzando instalación..."

# --- Detectar distribución ---
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "desconocido"
    fi
}

DISTRO=$(detect_distro)
echo "Detectada distribución: $DISTRO"

# --- Función para instalar paquetes según el sistema ---
install_package() {

    local pkg="$1"

    if [[ "$DISTRO" == "arch" ]]; then
        sudo pacman -S --noconfirm "$pkg"
    elif [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
        sudo apt-get install -y "$pkg"
    else
        echo "Distribución no soportada: $DISTRO"
        exit 1
    fi
}


# --- Instalar Homebrew si no está ---

echo "Verificando Homebrew..."

if ! command -v brew &> /dev/null; then
    echo "Homebrew no está instalado. Instalando..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
fi

# Cargar entorno de brew inmediatamente
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

echo "Homebrew configurado."


# --- Actualizar paquetes ---
echo "Actualizando paquetes..."

if [[ "$DISTRO" == "arch" ]]; then
    sudo pacman -Sy --noconfirm
else
    sudo apt-get update -y
    sudo apt-get upgrade -y
fi

# --- Instalar herramientas comunes ---
echo "Instalando herramientas necesarias..."


install_if_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo "Instalando $1..."

        install_package "$1"
    else
        echo "$1 ya está instalado."
    fi
}

# Básicos
install_if_missing zsh
install_if_missing tmux
install_if_missing curl
install_if_missing git
install_if_missing python3

# pip / ensurepip
if [[ "$DISTRO" == "arch" ]]; then
    install_if_missing python-pip

else
    install_if_missing python3-pip
fi

# Herramientas útiles
install_if_missing neovim
install_if_missing fzf
install_if_missing bat


# Extras por brew (no están en apt)
if ! command -v zoxide &>/dev/null; then
    echo "Instalando zoxide con brew..."
    brew install zoxide
fi

if ! command -v lsd &>/dev/null; then
    echo "Instalando lsd con brew..."
    brew install lsd
fi

# --- Cambiar shell por defecto a zsh ---
ZSH_PATH="$(command -v zsh)"

if [ "$SHELL" != "$ZSH_PATH" ]; then
    echo "Cambiando shell por defecto a $ZSH_PATH..."
    chsh -s "$ZSH_PATH" || echo "Fallo al cambiar el shell, hazlo manualmente con: chsh -s $ZSH_PATH"
fi

# --- Instalar uv ---
if ! command -v uv &>/dev/null; then

    if command -v brew &>/dev/null; then
        echo "Instalando uv con brew..."
        brew install uv
    else

        echo "Instalando uv manualmente..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.cargo/bin:$PATH"
    fi

else
    echo "uv ya está instalado."
fi

# Verificar uv disponible
if ! command -v uv &>/dev/null; then
    echo "Error: uv no está disponible después de instalarlo. Abortando."

    exit 1
fi

# --- Crear y activar entorno virtual ---
cd "${BASEDIR}"

if [ ! -d "${VENV_DIR}" ]; then
    echo "Creando entorno virtual en ${VENV_DIR}..."
    uv venv "${VENV_DIR}"
else
    echo "Entorno virtual ya existe en ${VENV_DIR}."
fi

echo "Activando entorno virtual..."
# shellcheck source=/dev/null
source "${VENV_DIR}/bin/activate"

echo "Asegurando que pip esté disponible en el entorno virtual..."
python3 -m ensurepip --upgrade || true

echo "Actualizando pip e instalando dotbot en entorno virtual..."
python3 -m pip install --upgrade pip dotbot


# --- Ejecutar dotbot ---
echo "Ejecutando dotbot con config ${CONFIG}..."
"${VENV_DIR}/bin/dotbot" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

exec zsh

