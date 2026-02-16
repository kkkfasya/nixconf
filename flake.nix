{
  # TODO: setup dev environment for
  # C, C++, Rust, Go, Nodejs, .NET (F#), Python,
  # and devops, docker, kube, podman
  # also networking stuff, tailscale, vpn, anything
  # also setup niri
  # also rebuild script

  #TODO:(2) modularize config

  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      fasya = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/fasya/configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
