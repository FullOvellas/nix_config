{ pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "gl_ES.UTF-8";
    LC_IDENTIFICATION = "gl_ES.UTF-8";
    LC_MEASUREMENT = "gl_ES.UTF-8";
    LC_MONETARY = "gl_ES.UTF-8";
    LC_NAME = "gl_ES.UTF-8";
    LC_NUMERIC = "gl_ES.UTF-8";
    LC_PAPER = "gl_ES.UTF-8";
    LC_TELEPHONE = "gl_ES.UTF-8";
    LC_TIME = "gl_ES.UTF-8";
  };

  i18n.inputMethod = {
    type.fcitx5.enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };
}
