{ pkgs, config, ... }:
{
  programs = {
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "fullovellas" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = true;
    pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
      hyprlock = {
        u2fAuth = true;
      };
    };
  };

  systemd.services.add-work-cert = {
    description = "Add work certificate to system trust store";
    wantedBy = [ "multi-user.target" ];
    after = [ "sops-nix.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.coreutils}/bin/cp ${config.sops.secrets.work-cert.path} /etc/ssl/certs/work-cert.crt
      ${pkgs.coreutils}/bin/chmod 644 /etc/ssl/certs/work-cert.crt
    '';
  };
}
