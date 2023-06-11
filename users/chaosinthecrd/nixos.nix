{ pkgs, lib, user, system, hyprland, ... }:

{
  imports = [(import ../../modules/desktop/hyprland/default.nix)];
  programs.zsh.enable = true;

  users.users.chaosinthecrd = {
    isNormalUser = true;
    home = "/home/chaosinthecrd";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
  };

}
