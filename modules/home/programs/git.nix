{
  programs = {
    git = {
      enable = true;
      signing.format = "openpgp";
      settings = {
        user = {
          name = "Sergio Alonso";
          email = "alo_se.r.g.io@proton.me";
        };
      };
    };
    lazygit.enable = true;
  };
}
