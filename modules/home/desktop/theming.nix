{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  theme = "${inputs.schemes}/base24/gruvbox-dark.yaml";
  wallpaperSource = ./wallpaper-source.jpg;

  wallpaper =
    pkgs.runCommand "remapped-wallpaper.png"
      {
        nativeBuildInputs = [
          pkgs.imagemagick
          pkgs.yq
        ];
      }
      ''
        # Extract the 24 base24 colors
        mkdir colors
        for i in 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17; do
          ${lib.getExe pkgs.yq} -r ".palette.base$i" ${theme} > colors/color$i
        done

        # Generate the palette image from the extracted hex codes
        convert $(for i in colors/*; do echo "xc:$(cat $i)"; done) +append -resize 24x1! palette.png

        # Remap the source image using the 24-color palette
        convert ${wallpaperSource} -quality 100 -dither Riemersma -remap palette.png $out
      '';
  wallpaperRemapper = pkgs.writeShellScriptBin "remap-wallpaper" ''
    set -e

    if [ $# -lt 1 ]; then
      echo "Usage: remap-wallpaper <input-image> [output-image]"
      echo "Example: remap-wallpaper wallpaper.jpg output.png"
      exit 1
    fi

    INPUT="$1"
    OUTPUT="''${2:-remapped-wallpaper.png}"

    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT

    # Extract the 24 base24 colors
    mkdir -p "$TEMP_DIR/colors"
    for i in 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17; do
      ${lib.getExe pkgs.yq} -r ".palette.base$i" "${theme}" > "$TEMP_DIR/colors/color$i"
    done

    # Generate the palette image from the extracted hex codes
    ${pkgs.imagemagick}/bin/convert \
      $(for i in "$TEMP_DIR/colors/"*; do echo "xc:$(cat $i)"; done) \
      +append -resize 24x1! "$TEMP_DIR/palette.png"

    # Remap the source image using the 24-color palette
    ${pkgs.imagemagick}/bin/convert \
      "$INPUT" -quality 100 -dither FloydSteinberg \
      -remap "$TEMP_DIR/palette.png" "$OUTPUT"

    echo "Remapped wallpaper saved to: $OUTPUT"
  '';
in
{
  home.packages = [ wallpaperRemapper ];
  stylix = {
    targets = {
      firefox.enable = false;
      nvf.enable = false;
      qt.enable = true;
      hyprland.hyprpaper.enable = false;
    };
    icons = {
      enable = true;
      package = pkgs.reversal-icon-theme;
      light = "Reversal";
      dark = "Reversal";
    };
    image = wallpaper;
    base16Scheme = theme;
  };
}
