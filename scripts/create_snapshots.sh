#!/bin/bash
set -e  # Detiene el script si ocurre algún error
# 📦 Configuración
DISPOSITIVO="/dev/nvme0n1p7"        # ← Cambia si tu partición Btrfs es diferente
PUNTO_MONTAJE="/mnt/snapshots"
FECHA=$(date +%Y-%m-%d_%H-%M)

# 📍 Subvolúmenes válidos (nombres lógicos)
SUBVOLUMENES=(
    "@"
    "@home"
    "@log"
    "@pkg"
    "@home-kuro"
)

# 📁 Rutas montadas de cada subvolumen (clave = nombre, valor = ruta real)
declare -A RUTAS_SUBVOLUMENES=(
    ["@"]="/"
    ["@home"]="/home"
    ["@log"]="/var/log"
    ["@pkg"]="/var/cache/pacman/pkg"
    ["@home-kuro"]="/home/kuro"
)

# 📂 Crear punto de montaje si no existe
mkdir -p "$PUNTO_MONTAJE"

# 🔐 Montar @snapshots
echo "🔐 Montando @snapshots en $PUNTO_MONTAJE..."
mount -o subvol=@snapshots "$DISPOSITIVO" "$PUNTO_MONTAJE"
if [ $? -ne 0 ]; then
    echo "❌ Error al montar @snapshots. Revisa el dispositivo: $DISPOSITIVO"
    exit 1
fi

# 📸 Función para crear snapshot de un subvolumen
crear_snapshot() {
    local SUBVOL=$1
    local SRC="${RUTAS_SUBVOLUMENES[$SUBVOL]}"
    local NAME=$(echo "$SUBVOL" | sed 's/@//')
    local DEST="$PUNTO_MONTAJE/${NAME}_${FECHA}"

    if [ ! -d "$SRC" ]; then
        echo "⚠️ Ruta origen no existe: $SRC — se omite $SUBVOL"
        return
    fi

    echo "📸 Creando snapshot de $SRC → $DEST"
    btrfs subvolume snapshot -r "$SRC" "$DEST" && \
    echo "✅ Snapshot creado: $DEST" || \
    echo "❌ Error al crear snapshot de $SRC"
}

# 🔁 Procesar subvolúmenes
if [ -z "$1" ]; then
    echo "🧾 Sin argumentos: creando snapshots de todos los subvolúmenes..."
    for SUBVOL in "${!RUTAS_SUBVOLUMENES[@]}"; do
        crear_snapshot "$SUBVOL"
    done
else
    echo "🔎 Procesando subvolúmenes solicitados: $1"
    IFS=',' read -ra SOLICITADOS <<< "$1"
    for REQ in "${SOLICITADOS[@]}"; do
        [[ "$REQ" != @* ]] && REQ="@${REQ}"
        if printf '%s\n' "${SUBVOLUMENES[@]}" | grep -qx "$REQ"; then
            crear_snapshot "$REQ"
        else
            echo "⚠️ Subvolumen no reconocido: $REQ — se omite"
        fi
    done
fi

# 📤 Desmontar punto de montaje
echo "📤 Desmontando $PUNTO_MONTAJE..."
umount "$PUNTO_MONTAJE"

echo "✅ Snapshots completados exitosamente."


