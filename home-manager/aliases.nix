{ system } :
{


# nvim
 v="nvim";
 vim="nvim";
 vi="nvim";

# System
 ".."="cd ..";
 "..."="cd ../..";
 ll="lsd -lh --group-dirs=first";
 la="lsd -a --group-dirs=first";
 l="lsd --group-dirs=first";
 lsa="lsd -lha --group-dirs=first";
 ls="lsd --group-dirs=first";
 cat="bat";
 "~"="cd ~";

# UV
 uvenv="uv venv";
 uvinstall="uv pip install";
 uvrun="uv run";
 pipenv="source .venv/bin/activate";

# Flutter
  pubspec="flutter pub add";

 dotfiles="cd $DOTFILES_PATH";
 code="cd $PROJECTS && clear";
 ".f"="cd $DOTFILES_PATH";
 t="tmux";

 nixdev= "nix develop . --system ${system} --command zsh";
}

