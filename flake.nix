{
	description = "Taminos flake";

	outputs = { self, nixpkgs, home-manager, ... }:
		let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "wini";
        profile = "personal";
        timezone = "Europe/Berlin";
        locale = "de_DE.UTF-8";
        keyboard = "de";
      };

      userSettings = {
        username = "tamino";
        name = "Tamino Larisch";
        dotfilesDir = "~/.dotfiles";
      };

			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${systemSettings.system};
		in {
		  nixosConfigurations = {
			  wini = lib.nixosSystem {
          system = systemSettings.system;
				  modules = [ ./configuration.nix ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

		  homeConfigurations = {
			  tamino = home-manager.lib.homeManagerConfiguration {
				  inherit pkgs;
				  modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
		  };
  };

  inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};
}
