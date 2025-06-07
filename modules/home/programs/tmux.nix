{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
      vim-tmux-navigator
      sensible
      yank
    ];
    shell = "${pkgs.nushell}/bin/nu";
    extraConfig = ''
      # colors
      set -g default-terminal "tmux-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      # mouse support
      set-option -g mouse on

      # Increase repeat-time window to allow for held keys in keybinds
      set -g repeat-time 700

      # Pane resizing bindings
      bind-key -r -T prefix C-k resize-pane -U
      bind-key -r -T prefix C-j resize-pane -D
      bind-key -r -T prefix C-h resize-pane -L
      bind-key -r -T prefix C-l resize-pane -R

      # Window navigation with Shift+Alt H/L
      bind -n M-H previous-window
      bind -n M-L next-window

      # Vi-like yanking
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      vim_pattern='(\\S+\\/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +''${vim_pattern}'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
    shortcut = "Space";
    keyMode = "vi";
    baseIndex = 1;
  };
}
