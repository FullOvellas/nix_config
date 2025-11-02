{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";
    };
    bashrcExtra = "export EDITOR=nvim";
  };
}
