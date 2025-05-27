{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    obs-studio
    spotify
    kew # terminal music player
    freetube
    # downloads
    ytdownloader
  ];
}
