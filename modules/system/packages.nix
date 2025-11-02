{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let
      python = pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.python-lsp-server
      ]);
    in
    with pkgs;
    [
      # system tools
      pciutils # lspci
      usbutils # lsusb
      nil
      git
      wget
      curl
      bc # gnu calculator
      bat
      nix-output-monitor
      #rclone
      unzip
      pkgs-stable.protonvpn-gui
      ## java
      temurin-bin-21
      jdk8
      jdt-language-server
      maven
      ## javascript
      typescript-language-server
      ## lua
      lua-language-server
      gcc
      llvmPackages.bintools
      ## rust
      cargo
      rustc
      rustfmt
      rust-analyzer
      clippy
      vscode-extensions.vadimcn.vscode-lldb
      # theming
      # sound
      pavucontrol
      # security
      yubioath-flutter
    ];
}
