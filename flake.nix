{
	description = "Taminos flake";

  outputs = { self, nixpkgs, home-manager, hyprland, ... }: #hyprland
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
          modules = [ ./configuration.nix 
            
            hyprland.nixosModules.default {
              services.greetd.enable = true;
              services.greetd.settings = {
                default_session = {
                  command = "Hyprland";
                  user = "tamino";
                };
              };
            } 
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit nixpkgs home-manager hyprland;
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
            inherit nixpkgs home-manager hyprland;
          };
        };
		  };
  };

  inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};
}
