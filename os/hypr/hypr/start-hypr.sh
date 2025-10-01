#!/bin/bash
# Puedes agregar más comandos aquí si quieres

# Lanzar Hyprland con logs redirigidos
exec Hyprland > ~/.cache/hyprland.log 2>&1

