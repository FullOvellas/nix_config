{ lib, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    configFile.source = ./config.nu;
    # for editing directly to config.nu
    extraConfig = ''
      # fish completions https://www.nushell.sh/cookbook/external_completers.html#fish-completer
      let fish_completer = {|spans|
      ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
        | $"value(char tab)description(char newline)" + $in
        | from tsv --flexible --no-infer
      }
      $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env |
        append ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter
      )
    '';
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      nano = "nvim";
      k = "kubectl";
    };
  };
}
