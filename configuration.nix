{ config, lib, pkgs, llm-agents, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.interop.appendWindowsPath = false;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
    llm-agents.packages.x86_64-linux.pi
  ];

  system.stateVersion = "25.11";
}
