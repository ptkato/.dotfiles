{
  description = "System config for @ptkato";

  inputs = {
    nixos-u.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-u.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixos-u, nixpkgs-u }: let
    system           = "x86_64-linux";
    nixos-unstable = import nixos-u {
      config.allowUnfree = true;
      localSystem = { inherit system; };
    };
    nixpkgs-unstable = import nixpkgs-u {
      config.allowUnfree = true;
      localSystem = { inherit system; };
    };
  in {
    nixosConfigurations.ptkato-desktop = nixos-u.lib.nixosSystem {
      system      = "x86_64-linux";
      modules     = [ ./configuration.nix ];
      specialArgs = {
        inherit nixos-unstable;
        inherit nixpkgs-unstable;
      };
    };
  };
}
