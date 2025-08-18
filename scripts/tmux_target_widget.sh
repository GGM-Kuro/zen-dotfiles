#!/usr/bin/env bash

TARGET_FILE="$DOTFILES_PATH/scripts/target"

# Colores Nord
COLOR_BG_DARK="#3B4252"
COLOR_BG_BLUE="#5E81AC"
COLOR_WHITE="#ECEFF4"
COLOR_GREEN="#88c0d0"
COLOR_YELLOW="#EBCB8B"
COLOR_RED="#BF616A"
COLOR_PURPLE="#b48ead"

# Si no existe el archivo
if [ ! -f "$TARGET_FILE" ]; then
    echo "#[fg=$COLOR_BG_BLUE,bg=$COLOR_BG_DARK]#[fg=$COLOR_WHITE,bg=$COLOR_BG_BLUE] No target #[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]#[default]"
    exit 0
fi

# Leer contenido y limpiar espacios/saltos

CONTENT=$(tr -d '\r' < "$TARGET_FILE" | sed 's/^ *//;s/ *$//')

# Si está vacío realmente
if [ -z "$CONTENT" ]; then
    echo "#[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]#[default]#[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]   #[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]"
    exit 0

fi

# Extraer IP y nombre
IP="${CONTENT%% *}"
NAME="${CONTENT#* }"

# Mostrar bloque con colores
echo "#[fg=$COLOR_BG_DARK,bg=$COLOR_GREEN]#[fg=$COLOR_BG_DARK,bg=$COLOR_GREEN] Target #[fg=$COLOR_GREEN,bg=$COLOR_BG_DARK]#[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]#[fg=$COLOR_YELLOW]#[fg=$COLOR_PURPLE] $NAME #[fg=$COLOR_BG_BLUE,bg=$COLOR_BG_DARK]#[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]#[fg=$COLOR_YELLOW] $IP #[fg=$COLOR_BG_DARK,bg=$COLOR_BG_BLUE]#[fg=$COLOR_BG_BLUE,bg=$COLOR_BG_DARK]#[fg=$COLOR_GREEN,bg=$COLOR_BG_BLUE]   "

