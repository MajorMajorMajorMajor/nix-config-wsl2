{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.interop.appendWindowsPath = false;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
