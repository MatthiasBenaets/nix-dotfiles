{ config, lib, pkgs, system, ... }:
let
  # exec = with host; if hostName == "work" then "exec nvidia-offload Hyprland" else "exec Hyprland"; # Starting Hyprland with nvidia (bit laggy so disabling)
  exec = "exec Hyprland";
in
{

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        ${exec}
      fi
    '';                                   # Will automatically open Hyprland when logged into tty1

    variables = {
      #WLR_NO_HARDWARE_CURSORS="1";         # Possible variables needed in vm
      #WLR_RENDERER_ALLOW_SOFTWARE="1";
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    # keeping for nvidia times
    # sessionVariables = {
    #   #GBM_BACKEND = "nvidia-drm";
    #   #__GL_GSYNC_ALLOWED = "0";
    #   #__GL_VRR_ALLOWED = "0";
    #   #WLR_DRM_NO_ATOMIC = "1";
    #   #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #   #_JAVA_AWT_WM_NONREPARENTING = "1";
    #
    #   QT_QPA_PLATFORM = "wayland";
    #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    #
    #   GDK_BACKEND = "wayland";
    #   WLR_NO_HARDWARE_CURSORS = "1";
    #   MOZ_ENABLE_WAYLAND = "1";
    # } else {
      sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      swappy
      swaylock
      wl-clipboard
      wlr-randr
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      #nvidiaPatches = with host; if hostName == "work" then true else false;
    };
  };

  xdg.portal = {                                  # Required for flatpak with window managers and for file browsing
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

}
