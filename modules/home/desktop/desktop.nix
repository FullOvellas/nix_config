{ config, pkgs, ... }:
{
  programs = {
    wlogout = {
      enable = true;
      layout = builtins.fromJSON (builtins.readFile ./wlogout/layout.json);
      style = ./wlogout/style.css;
    };
    rofi =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = {
          "*" = {
            font = "JetBrainsMono NF 18";
            active-background = mkLiteral "var(gruvbox-dark-yellow-dark)";
            active-foreground = mkLiteral "var(foreground)";
            alternate-active-background = mkLiteral "var(active-background)";
            alternate-active-foreground = mkLiteral "rgba (29,32,33,1)";
            alternate-normal-background = mkLiteral "var(gruvbox-dark-bg0)";
            alternate-normal-foreground = mkLiteral "var(foreground)";
            alternate-urgent-background = mkLiteral "var(urgent-background)";
            alternate-urgent-foreground = mkLiteral "var(urgent-foreground)";
            background = mkLiteral "var(gruvbox-dark-bg0-hard)";
            background-color = mkLiteral "var(background)";
            border-color = mkLiteral "var(gruvbox-dark-gray)";
            foreground = mkLiteral "var(gruvbox-dark-fg1)";
            gruvbox-dark-bg0 = mkLiteral "rgba (40,40,40,0.2)";
            gruvbox-dark-bg0-hard = mkLiteral "rgba (29,32,33,0.5)";
            gruvbox-dark-bg2 = mkLiteral "rgba ( 80, 73, 69, 0.5)";
            gruvbox-dark-fg0 = mkLiteral "rgba ( 251, 241, 199, 100%)";
            gruvbox-dark-fg1 = mkLiteral "rgba ( 235, 219, 178, 100%)";
            gruvbox-dark-gray = mkLiteral "rgba ( 168, 153, 132, 100%)";
            gruvbox-dark-red-dark = mkLiteral "rgba ( 204, 36, 29, 0.5)";
            gruvbox-dark-red-light = mkLiteral "rgba ( 251, 73, 52, 0.5)";
            gruvbox-dark-yellow-dark = mkLiteral "rgba ( 215, 153, 33, 0.5)";
            gruvbox-dark-yellow-light = mkLiteral "rgba ( 250, 189, 47, 0.5)";
            highlight = mkLiteral "bold italic";
            normal-background = mkLiteral "var(background)";
            normal-foreground = mkLiteral "var(foreground)";
            scrollbar = mkLiteral "true";
            scrollbar-handle = mkLiteral "var(border-color)";
            selected-active-background = mkLiteral "var(gruvbox-dark-yellow-light)";
            selected-active-foreground = mkLiteral "var(active-foreground)";
            selected-normal-background = mkLiteral "var(gruvbox-dark-bg2)";
            selected-normal-foreground = mkLiteral "var(gruvbox-dark-fg0)";
            selected-urgent-background = mkLiteral "var(gruvbox-dark-red-light)";
            selected-urgent-foreground = mkLiteral "var(urgent-foreground)";
            separatorcolor = mkLiteral "var(border-color)";
            urgent-background = mkLiteral "var(gruvbox-dark-red-dark)";
            urgent-foreground = mkLiteral "var(background)";
          };

          "button" = {
            spacing = 0;
            text-color = mkLiteral "var(normal-foreground)";
          };

          "button selected" = {
            background-color = mkLiteral "var(selected-normal-background)";
            text-color = mkLiteral "var(selected-normal-foreground)";
          };

          "case-indicator" = {
            spacing = 0;
            text-color = mkLiteral "var(normal-foreground)";
          };

          "element" = {
            border = 0;
            #       padding = mkLiteral "4px";
            anchor = mkLiteral "center";
            location = mkLiteral "center";
          };

          "element alternate.active" = {
            background-color = mkLiteral "var(alternate-active-background)";
            text-color = mkLiteral "var(alternate-active-foreground)";
          };

          "element alternate.normal" = {
            background-color = mkLiteral "var(alternate-normal-background)";
            text-color = mkLiteral "var(alternate-normal-foreground)";
          };

          "element alternate.urgent" = {
            background-color = mkLiteral "var(alternate-urgent-background)";
            text-color = mkLiteral "var(alternate-urgent-foreground)";
          };

          "element normal.active" = {
            background-color = mkLiteral "var(active-background)";
            text-color = mkLiteral "var(active-foreground)";
          };

          "element normal.normal" = {
            background-color = mkLiteral "var(normal-background)";
            text-color = mkLiteral "var(normal-foreground)";
          };

          "element normal.urgent" = {
            background-color = mkLiteral "var(urgent-background)";
            text-color = mkLiteral "var(urgent-foreground)";
          };

          "element selected.active" = {
            background-color = mkLiteral "var(selected-active-background)";
            text-color = mkLiteral "var(selected-active-foreground)";
          };

          "element selected.normal" = {
            background-color = mkLiteral "var(selected-normal-background)";
            text-color = mkLiteral "var(selected-normal-foreground)";
          };

          "element selected.urgent" = {
            background-color = mkLiteral "var(selected-urgent-background)";
            text-color = mkLiteral "var(selected-urgent-foreground)";
          };

          "element-icon" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
            size = mkLiteral "1.2em";
            padding = mkLiteral "3px";
          };

          "element-text" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
            anchor = mkLiteral "center";
            location = mkLiteral "center";
          };

          "entry" = {
            spacing = 0;
            text-color = mkLiteral "var(normal-foreground)";
            anchor = mkLiteral "center";
            location = mkLiteral "center";
          };

          "inputbar" = {
            border = mkLiteral "0px 0px 2px 0px";
            border-color = mkLiteral "var(separatorcolor)";
            children = [
              "prompt"
              "textbox-prompt-sep"
              "entry"
              "case-indicator"
            ];
            padding = mkLiteral "2px";
            spacing = 0;
            text-color = mkLiteral "var(normal-foreground)";
          };

          "listview" = {
            #       padding = mkLiteral "2px 0px 0px";
            scrollbar = mkLiteral "var(scrollbar)";
          };

          "mainbox" = {
            orientation = mkLiteral "vertical";
            border = 0;
            padding = 0;
          };

          #     "message" = {
          #       border = mkLiteral "2px 0px 0px";
          #       border-color = mkLiteral "var(separatorcolor)";
          #       padding = mkLiteral "1px";
          #     };

          "mode-switcher" = {
            border = mkLiteral "2px 0px 0px";
            border-color = mkLiteral "var(separatorcolor)";
          };

          "prompt" = {
            spacing = 0;
            text-color = mkLiteral "var(normal-foreground)";
          };

          "scrollbar" = {
            border = 0;
            handle-color = mkLiteral "var(scrollbar-handle)";
            handle-width = mkLiteral "8px";
            padding = 0;
            width = mkLiteral "4px";
          };

          "textbox" = {
            highlight = mkLiteral "var(highlight)";
            text-color = mkLiteral "var(foreground)";
          };

          "textbox-prompt-sep" = {
            expand = mkLiteral "false";
            margin = mkLiteral "0px 0.3000em 0px 0px";
            str = ":";
            text-color = mkLiteral "var(normal-foreground)";
          };

          "window" = {
            width = mkLiteral "25%";
            height = mkLiteral "55%";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            background-color = mkLiteral "var(background)";
          };
        };
      };
  };
}
