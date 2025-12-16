{
  description = "rick flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ragenix, ... }@attrs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.rick = nixpkgs.lib.nixosSystem rec {
      inherit system;
      specialArgs = attrs // { inherit system; };
      modules = [
#        disko.nixosModules.disko
        ragenix.nixosModules.default
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
