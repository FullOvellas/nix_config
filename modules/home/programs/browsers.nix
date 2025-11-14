{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    chromium
    tor-browser
    offpunk
  ];
}
