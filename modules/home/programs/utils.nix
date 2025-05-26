{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # (de)compression
    zip
    xz
    unzip
    p7zip
    gnutar
    gzip
    #security
    gnupg
    # misc
    tree
    eza # ls replacement
    fzf # Command-line fuzzy finder
    glow # Command-line Markdown viewer
    ripgrep # recursively searches directories for a regex pattern
    nnn # terminal file manager
  ];
  programs.zoxide.enable = true;
}
