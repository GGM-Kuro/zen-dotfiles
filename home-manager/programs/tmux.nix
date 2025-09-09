{ config, pkgs, ... }:
{
  enable = true;
  terminal = "tmux-256color";

  historyLimit = 8000;
  escapeTime = 1;
  baseIndex = 1;
  shortcut = "a";
  plugins = with pkgs.tmuxPlugins; [
    nord
    sensible
    tmux-fzf
    resurrect
  ];
  extraConfig = ''
         set -g @plugin 'tmux-plugins/tpm'



         # Fix colors for the terminal
         set -g terminal-overrides ',xterm-256color:Tc'

         





         # Floating window
         bind-key -n M-g if-shell -F '#{==:#{session_name},scratch}' {
         detach-client
         } {
         # open in the same directory of the current pane
         display-popup -d "#{pane_current_path}" -E "tmux new-session -A -s scratch"
         }


         # Plugins
         source-file $DOTFILES_PATH/os/linux/tmux/navigation.conf


         # Mouse support
         set -g mouse on

         # Fix index
         set -g base-index 1
         setw -g pane-base-index 1
         set -g status-position top


         run '~/.tmux/plugins/tpm/tpm'

         # customs
         set -g status-right "#($DOTFILES_PATH/scripts/tmux_target_widget.sh)"


         # Keymaps
         unbind C-x
         set -g prefix C-a
         bind C-a send-prefix
         unbind %
         unbind '"'
         unbind -T root C-n
         unbind -T copy-mode C-n
         unbind-key C-n
         bind v split-window -h -c '#{pane_current_path}'
         bind d split-window -v -c '#{pane_current_path}'
         set -g @resurrect-save 'prefix + S'
  '';
}
