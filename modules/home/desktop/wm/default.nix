{ config, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source = ${config.sops.secrets.monitor.path}
      ${builtins.readFile ../../dotfiles/hyprland/hyprland.conf}
    '';
    settings = { };
  };
  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
        };
        # background = {
        #   path = "screenshot";
        #   blur_passes = 2;
        # };
        label = [
          {
            text = "cmd[update:30000] echo \"$(date +'%H:%M')\"";
            font_size = 90;
            position = "-130, -100";
            halign = "right";
            valign = "top";
            shadow_passes = 2;
            font = "JetBrainsMono Nerd Font Mono";
          }
          {
            text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
            font_size = 25;
            position = "-130, -250";
            halign = "right";
            valign = "top";
            shadow_passes = 2;
            font = "JetBrainsMono Nerd Font Mono";
          }
        ];
      };
      # extraConfig = builtins.readFile ../../dotfiles/hyprland/hyprlock.conf;
    };
    wlogout = {
      enable = true;
      layout = builtins.fromJSON (builtins.readFile ./wlogout/layout.json);
      style = ./wlogout/style.css;
    };
    waybar.enable = false;
    hyprpanel = {
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
            opacity = 90;
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
  };
  services = {
    mako.enable = false;
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        # preload = [ "/home/fullovellas/Pictures/wallpaper/flower.jpg" ];
        # wallpaper = [ ",/home/fullovellas/Pictures/wallpaper/flower.jpg" ];
      };
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 480;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 900;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
