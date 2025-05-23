{
  programs.alacritty =
    let
      console_font = "JetBrainsMono NF";
      #   console_font = "Zpix";
      #   console_font = "Rounded Mgen+ 1m";
    in
    {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        font = {
          normal = {
            family = console_font;
            style = "Regular";
          };
          bold = {
            family = console_font;
            style = "Bold";
          };
          italic = {
            family = console_font;
            style = "Italic";
          };
          bold_italic = {
            family = console_font;
            style = "Bold Italic";
          };
          size = 11;
        };
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
        window.padding = {
          x = 3;
          y = 1;
        };
        window.opacity = 0.85;
      } // (builtins.fromTOML (builtins.readFile ./alacritty_themes/gruvbox_dark.toml));
    };
}
