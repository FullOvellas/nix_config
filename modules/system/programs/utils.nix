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
    extraConfig = ''
      # default shell
      set-option -g default-shell ${pkgs.nushell}/bin/nu
      # colors
      set-option -sa terminal-overrides ",xterm*:Tc"
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
    '';
    shortcut = "Space";
    keyMode = "vi";
    baseIndex = 1;
  };
}
