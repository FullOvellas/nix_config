{ config, lib, ... }:
{
  programs.hyprpanel = {
    enable = true;
    settings = {
      menus = {
        media.displayTimeTooltip = true;
        clock = {
          time.military = true;
          weather.enabled = false;
        };
      };
      bar = {
        workspaces = {
          showWsIcons = true;
          workspaceIconMap = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
          };
        };
        layouts = {
          "*" = {
            left = [
              "storage"
              "ram"
              "media"
              "windowtitle"
            ];
            middle = [ "workspaces" ];
            right = [
              "network"
              "volume"
              "kbinput"
              "systray"
              "hypridle"
              "clock"
              "notifications"
            ];
          };
        };
        clock.format = "%H:%M:%S";
        customModules.storage = {
          leftClick = "baobab";
        };
      };
      launcher.autoDetectIcon = false;

      theme = {
        bar = {
          transparent = false;
          floating = true;
          opacity = 85;
          margin_top = "0.4em";
          outer_spacing = "0.8em";
          buttons = {
            background_opacity = 0;
            background_hover_opacity = 70;
            workspaces = {
              occupied = lib.mkForce "#83a598";
            };
          };
          media = {
            truncation_size = 40;
          };
        };

        font = {
          name = "JetBrainsMono Nerd Font Mono";
          size = "13.5px";
        };
      };
    };
  };
}
