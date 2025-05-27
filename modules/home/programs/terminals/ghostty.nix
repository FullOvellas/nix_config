{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    installBatSyntax = true;
    settings = {
      theme = "GruvboxDark";
      background-opacity = 0.85;
      font-size = 12;
      keybind = [
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
      ];
    };
  };
}
