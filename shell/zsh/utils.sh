if [[ ! -d "$WINHOME/AppData/Roaming/alacritty" ]]; then
    cp -r $HOME/.dotfiles/os/wsl/alacritty/ $WINHOME/AppData/Roaming/alacritty/
fi
