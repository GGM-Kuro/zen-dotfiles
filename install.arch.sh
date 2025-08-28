#!/usr/bin/env bash
set -euo pipefail

CONFIG="symlink/conf.yaml"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${BASEDIR}/.venv"

echo "==> Comenzando instalación..."

echo "Verificando Homebrew..."

if ! command -v brew &> /dev/null; then
    echo "Homebrew no está instalado. Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Configurar el entorno para brew (ajusta según tu shell)
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Homebrew ya está instalado."
fi

# --- Verificar y actualizar dependencias ---

echo "Verificando dependencias con pacman y brew..."

# Actualizar lista de paquetes
sudo pacman -Sy --noconfirm

# Instalar zsh si no está
if ! command -v zsh &>/dev/null; then
    echo "Instalando zsh con pacman..."
    sudo pacman -S --noconfirm zsh
else
    echo "zsh ya esta instalado."
fi

echo "Instalando herramientas necesarias..."

install_if_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo "Instalando $1..."
        sudo pacman -S --noconfirm "$1"
    else
        echo "$1 ya está instalado."
    fi
}

install_if_missing neovim
install_if_missing fzf
install_if_missing zoxide
install_if_missing lsd
install_if_missing bat


# Cambiar shell por defecto a zsh si no es
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo "Cambiando shell por defecto a /usr/bin/zsh..."
    chsh -s /usr/bin/zsh || echo "Fallo cambiar shell, hazlo manualmente."
fi

# Instalar curl si no está
if ! command -v curl &>/dev/null; then
    echo "Instalando curl con pacman..."
    sudo pacman -S --noconfirm curl
else
    echo "curl ya está instalado."
fi

# Instalar python y pip si no están
if ! command -v python &>/dev/null; then
    echo "Instalando python..."
    sudo pacman -S --noconfirm python
fi

if ! command -v pip &>/dev/null && ! python -m pip --version &>/dev/null; then
    echo "Instalando python-pip..."
    sudo pacman -S --noconfirm python-pip
else
    echo "pip ya está instalado."
fi

# Instalar uv si no está (usando brew si está, si no, método oficial)
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
python -m ensurepip --upgrade || true

echo "Actualizando pip e instalando dotbot en entorno virtual..."
python -m pip install --upgrade pip dotbot

# --- Ejecutar dotbot ---

echo "Ejecutando dotbot con config ${CONFIG}..."

echo "Ejecutando dotbot con config ${CONFIG}..."
"${VENV_DIR}/bin/dotbot" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

zsh

