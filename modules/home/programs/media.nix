{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vlc
    obs-studio
    spotify
    freetube
    # downloads
    ytdownloader
  ];
}
