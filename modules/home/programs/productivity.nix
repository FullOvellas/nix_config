{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
    foliate
    anki
  ];
}
