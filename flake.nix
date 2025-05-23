{
  description = "FullOvellas's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jujutsu = {
      url = "github:jj-vcs/jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    starship-jj = {
      url = "gitlab:lanastara_foss/starship-jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@gitlab.com/FullOvellas/nix_secrets.git?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-stable,
      zen-browser,
      rose-pine-hyprcursor,
      nix-vscode-extensions,
      jujutsu,
      starship-jj,
      neorg-overlay,
      secrets,
      ...
    }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            inherit nixpkgs;
            inherit nix-vscode-extensions;
            inherit rose-pine-hyprcursor;
            inherit zen-browser;
            inherit home-manager;
            inherit jujutsu;
            inherit starship-jj;
            inherit secrets;
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [ neorg-overlay.overlays.default ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.fullovellas = (import ./home.nix);
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit secrets; };
            }
          ];
        };
      };
      devShells = {
        x86_64-linux.default =
          let
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          in
          pkgs.mkShell {
            name = "flake editing shell";

            buildInputs = [
              pkgs.nixfmt-rfc-style
              pkgs.nushell
            ];
          };
      };
    };
}
