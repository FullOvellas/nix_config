{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    installBatSyntax = true;
    settings = {
      theme = "Gruvbox Dark";
      background-opacity = 0.9;
      font-size = 10;
      keybind = [
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+shift+v=paste_from_clipboard"
      ];
      custom-shader = "${./cursor_smear.glsl}";
    };
  };
}
