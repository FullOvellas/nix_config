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

This uses [sops-nix](https://github.com/Mic92/sops-nix) for a couple details I wanted to keep private.

At this point it's almost superfluous, but the skeleton for more secrets is there now.
