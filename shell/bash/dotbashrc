
[[ ! -f ~/.dotfiles/shell/init ]] || source ~/.dotfiles/shell/init
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ $- == *i* ]]; then  # Solo en sesiones interactivas
	source "$DOTFILES_PATH/shell/bash/fzf-completion/bash/fzf-bash-completion.sh"
fi

export FZF_COMPLETION_TRIGGER='\t'
export FZF_COMPLETION_OPTS='--height 40% --layout=reverse --border --preview "bat --style=numbers --color=always {} 2>/dev/null || ls -lh --color=always {}"'
_fzf_complete_all() {
    local word="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(compgen -f -- "$word" | fzf))
}
# Reemplaza el completado por defecto de archivos
complete -o default -F _fzf_complete_all -D


alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# zsh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
