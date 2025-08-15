#!/bin/bash

set -euo pipefail

dotbot -d "$DOTFILES_PATH" -c "$DOTFILES_PATH/symlink/conf.yaml

if [ $# -ne 0 ]; then
dotbot -d "$DOTFILES_PATH" -c "$DOTFILES_PATH/symlink/conf.${1}.yaml"
fi

echo "Dotbot ha generado los enlaces simbolicos correctamente"
