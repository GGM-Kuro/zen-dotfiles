zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion::*:ls::*' fzf-completion-opts --preview='eval head {1}'
zstyle ':completion:*' fzf-search-display true
# make it red instead
zstyle ':completion:*' fzf-completion-secondary-color red
