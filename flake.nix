{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, zen-browser, nvf, ... }: 
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        # AI
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
	  modules/configuration.nix
          ./modules/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {  
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; inherit system; };
              users.jjoaoll = import ./modules/home;
            };
          }
        ];
      };
    };

  #  # AI
  #  devShells.${system}.default = let
  #    pkgs = nixpkgs.legacyPackages.${system};
  #    unstable = nixpkgs-unstable.legacyPackages.${system};
  #  in import ./shell.nix { inherit pkgs unstable; };
  };
}
