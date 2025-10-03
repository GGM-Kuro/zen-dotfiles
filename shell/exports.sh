        # ------------------------------------------------------------------------------
        # Languages
        # ------------------------------------------------------------------------------
        export PIPENV_VENV_IN_PROJECT=1

        # ------------------------------------------------------------------------------
        # Custom
        # ------------------------------------------------------------------------------

        [[ -f "/mnt/d/kuro" ]] || export WINHOME="/mnt/c/kuro"

        export PROJECTS="$HOME/code"
        export ANDROID_HOME="$HOME/.config/.android/"
        export ANDROID_SDK_HOME="$HOME/Android/Sdk/"

        if [[ "$(uname)" == "Darwin" ]]; then
          export BREW_BIN="/opt/homebrew/bin"
        else
          export BREW_BIN="/home/linuxbrew/.linuxbrew/bin"
        fi

        # Load brew
        if [ -x "$BREW_BIN/brew" ]; then
          eval "$($BREW_BIN/brew shellenv)"
        fi

        if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
          . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi


        # ------------------------------------------------------------------------------
        # Terminal
        # ------------------------------------------------------------------------------

        export XDG_CONFIG_HOME=$HOME/.config
        export INPUTRC="$DOTFILES_PATH/shell/bash/.inputrc"
        export TERM=xterm-256color
        export COLORTERM=truecolor


        export FZF_DEFAULT_OPTS="--color=$fzf_colors --reverse"
        export FZF_DEFAULT_OPTS="-e \
            --color=bg+:#232530,bg:#1c1e26,spinner:#24a8b4,hl:#df5273\
            --color=fg:#9da0a2,header:#df5273,info:#efb993,pointer:#24a8b4\
            --color=marker:#24a8b4,fg+:#dcdfe4,prompt:#efb993,hl+:#df5273

            --reverse"
        export MYVIMRC="$DOTFILES_PATH/editors/nvim/"

        export LS_COLORS="rs=0:di=34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"


        # ------------------------------------------------------------------------------
        # Path - The higher it is, the more priority it has
        # ------------------------------------------------------------------------------

        path=(
          "$HOME/.local/state/nix/profiles/home-manager/home-path/bin"
        	"/home/linuxbrew/.linuxbrew/bin"
        	"/usr/local/opt/ruby/bin"
        	"/usr/local/bin"
        	"/usr/local/sbin"
        	"/bin"
        	"/usr/bin"
        	"/usr/sbin"
        	"/sbin"
            "$ANDROID_HOME/emulator"

        	"$path"
        )


        export path

