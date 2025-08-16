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
      ethtool
      pciutils # lspci
      usbutils # lsusb
      nil
      git
      inputs.jujutsu.packages.${system}.default
      wget
      curl
      bc # gnu calculator
      bat
      inputs.starship-jj.packages.${system}.default
      nix-output-monitor
      #rclone
      unzip
      protonvpn-gui
      # dev
      #vscodium
      ## Python
      python
      ## java
      #[use this if unstable breaks] inputs.pkgs-stable.jetbrains.idea-community
      temurin-bin-21
      jdk8
      jdt-language-server
      maven
      ## javascript
      nodejs
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
