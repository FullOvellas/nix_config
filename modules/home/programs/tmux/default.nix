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
    extraConfig = builtins.readFile ./tmux.conf;
    shortcut = "Space";
    keyMode = "vi";
    baseIndex = 1;
  };
}
