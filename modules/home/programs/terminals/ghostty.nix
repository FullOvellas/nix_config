{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    installBatSyntax = true;
    settings = {
      theme = "GruvboxDark";
      background-opacity = 0.85;
      font-size = 10;
      keybind = [
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
