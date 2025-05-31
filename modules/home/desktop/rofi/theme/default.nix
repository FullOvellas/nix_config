{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  # imports = [ ./colors.nix ]; excluded in favor of stylix, kept as backup
  programs.rofi.theme = {
    "button" = {
      spacing = 0;
    };

    "case-indicator" = {
      spacing = 0;
    };

    "element" = {
      border = 0;
      anchor = mkLiteral "center";
      location = mkLiteral "center";
    };

    "element-icon" = {
      size = mkLiteral "1.3em";
      padding = mkLiteral "3px";
    };

    "element-text" = {
      anchor = mkLiteral "center";
      location = mkLiteral "center";
    };

    "entry" = {
      spacing = 0;
      anchor = mkLiteral "center";
      location = mkLiteral "center";
    };

    "inputbar" = {
      border = mkLiteral "0px 0px 2px 0px";
      children = [
        "prompt"
        "textbox-prompt-sep"
        "entry"
        "case-indicator"
      ];
      padding = mkLiteral "2px";
      spacing = 0;
    };

    "listview" = {
      scrollbar = mkLiteral "true";
    };

    "mainbox" = {
      orientation = mkLiteral "vertical";
      border = 0;
      padding = 0;
    };

    "mode-switcher" = {
      border = mkLiteral "2px 0px 0px";
    };

    "prompt" = {
      spacing = 0;
    };

    "scrollbar" = {
      border = 0;
      handle-width = mkLiteral "8px";
      padding = 0;
      width = mkLiteral "4px";
    };

    "textbox-prompt-sep" = {
      expand = mkLiteral "false";
      margin = mkLiteral "0px 0.3000em 0px 0px";
      str = ":";
    };

    "window" = {
      width = mkLiteral "25%";
      height = mkLiteral "55%";
      location = mkLiteral "center";
      anchor = mkLiteral "center";
    };
  };
}
