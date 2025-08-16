{ pkgs, ... }:
let
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
{
  home.packages = with pkgs; [
    retroarchWithCores
    cemu
    ryubing
    pcsx2
  ];
}
