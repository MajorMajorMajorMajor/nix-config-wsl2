{
  description = "NixOS configuration for WSL2";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Your fork of numtide's llm-agents collection (includes pi-agent)
    llm-agents = {
      url = "github:MajorMajorMajorMajor/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, llm-agents }:
    let
      system = "x86_64-linux";
    in
    {
      # System configuration
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit llm-agents; };
        modules = [
          nixos-wsl.nixosModules.default
          ./configuration.nix
        ];
      };

      # Re-export pi-agent from your fork
      packages.${system} = {
        pi-agent = llm-agents.packages.${system}.pi;
        default = llm-agents.packages.${system}.pi;
      };

      # Apps (shortcuts to run packages)
      apps.${system} = {
        pi = {
          type = "app";
          program = "${llm-agents.packages.${system}.pi}/bin/pi";
        };
        default = self.apps.${system}.pi;
      };
    };
}
