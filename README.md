# FullOvellas's NixOS system

My system-on-a-flake! This repository aims to recreate my system in a purely declarative way as much as possible.

Some notable features of this system:

- Gruvbox theming (when possible)
- Alacritty as the terminal emulator
- Zen and Chromium as browsers
- Uses unfree packages
- Customized Hyprland environment
- Includes Gnome, just in case, and also to use some of its packages in Hyprland
- Tmux configuration
- Home-made Neovim configuration, with LSPs and debugging support (for a few languages)

## Disclaimer

I'm not very knowledgeable about either NixOS, Nix or system administration! Also, this system is very much tailored
to my particular tastes.

## Structure

The system is defined in a modular way to make it easier to reuse and change at will. At each level there's a nix file
which imports all files in the same level and/or the module below.

I tried to create all necessary dotfiles using this flake, either through 
[home-manager](https://github.com/nix-community/home-manager) options, writing files directly with home-manager or
through nixpkgs configurations.

## Secret management

Something like [sops-nix](https://github.com/Mic92/sops-nix) is probably overkill for this, so in order to maintain
some details private I used the somewhat hacky approach of having a flake with my secrets hosted on a private
repository as an input to improve purity of evaluation. This means you can't use this flake out of the box without
stealing my credentials, but please don't do that! You will have to provide your own secrets or refactor the code a bit
to not use any.

