{ pkgs, specialArgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let
      vscodiumExtensions = specialArgs.nix-vscode-extensions.extensions."x86_64-linux";
      python = pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.python-lsp-server
      ]);
      retroarchWithCores = (
        pkgs.retroarch.withCores (
          cores: with cores; [
            beetle-pce
            bsnes
            gpsp
            melonds
            mgba
            snes9x
            swanstation
          ]
        )
      );
    in
    with pkgs;
    [
      nil
      git
      specialArgs.jujutsu.packages.${system}.default
      wget
      curl
      filezilla
      vlc
      bc # gnu calculator
      bat
      specialArgs.starship-jj.packages.${system}.default
      #rclone
      tor-browser-bundle-bin
      transmission_4
      unzip
      ytdownloader
      specialArgs.pkgs-stable.protonvpn-gui
      protonmail-desktop
      syncthing
      obs-studio
      # productivity
      obsidian
      foliate
      # messaging
      signal-desktop
      # browsers
      specialArgs.zen-browser.packages.${system}.default
      chromium
      # dev
      #vscodium
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscodiumExtensions; [
        ];
      })
      ## Python
      python
      ## java
      #[use this if unstable breaks] specialArgs.pkgs-stable.jetbrains.idea-community
      jetbrains.idea-community
      temurin-bin-21
      jdk8
      jdt-language-server
      maven
      ## javascript
      nodejs
      typescript-language-server
      ## lua
      lua-language-server
      insomnia
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
      #hyprland
      hyprpaper
      grim # screenshots
      slurp # screenshot region selector
      swappy # screenshot edit
      hypridle
      hyprland-qtutils
      kdePackages.qt6ct
      # moved to home manager rofi-wayland # launcher
      wl-clipboard
      ## notifications
      mako
      #dunst
      libnotify
      ## Status bar
      waybar
      ### bar stuff
      blueman
      networkmanagerapplet
      waybar-mpris
      playerctl
      syncthingtray
      # entertainment
      spotify
      ## games
      gamescope
      duckstation
      retroarchWithCores
      cemu
      ryujinx
      pcsx2
      freetube
      # security
      yubioath-flutter
    ];
}
