{ config, pkgs, lib, ... }: {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;

    services.emacs = {
        enable = true;
        # defaultEditor = true;
    };
    # services.displayManager.sddm.enable = true;
    # Força os aplicativos Electron (como Vesktop, Obsidian, VSCode) a usarem o X11
    environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "x11";

    # Habilita o ambiente desktop KDE Plasma (versão 6).
    services.desktopManager.plasma6.enable = true;
    programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

    # GTK THINGS
    # services.xserver.desktopManager.gnome.enable = true;
    programs.dconf.enable = lib.mkDefault true;
    services.dbus.packages = [ pkgs.at-spi2-core ];

    services.flatpak.enable = true;
    #https://nixos.wiki/wiki/Flatpak
    systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
         flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
         '';
    };
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ 
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
        ];
        config = {
            common = {
                default = [ "gtk" ];
            };
            plasma = {
                default = [ "kde" ];
            };
            gnome = {
                default = [ "gnome" ];
            };
        };
        # config.common.default = "gnome";
    };
    services.gnome.gnome-software.enable = true;
    # programs.gnome-software.enable = true;
    environment.systemPackages = with pkgs; [
        flatpak
        flatpak-builder
        # gnome-software
        appstream
        appstream-glib

        # wine
        wineWowPackages.stable 
        winetricks # fonts and extra dlls
        bottles    # gui
        lutris     # gamming 
    ];
    # GTK THINGS


    system.autoUpgrade.enable = true;
    # system.autoUpgrade.allowReboot = true;





    # NVIDIA drivers
    # -----------------------------------------------------------------

    # boot.kernelParams = [ 
    #     "nvidia-drm.modeset=1" 
    #     "video=DP-1:1920x1080@360"
    # ];
    hardware.nvidia = {
        open                   = false;
        modesetting.enable     = true;
        # powerManagement.enable = false;
        powerManagement.enable = true;
        nvidiaSettings         = true;
        # package = config.boot.kernelPackages.nvidiaPackages.stable;
        package = config.boot.kernelPackages.nvidiaPackages.latest; 
    };

# services.xserver.displayManager.gdm.wayland = false;
boot.kernelParams = [ "nvidia-drm.modeset=1" ];

    # -----------------------------------------------------------------
    # Gaming Compatibility
    # -----------------------------------------------------------------

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages32 = with pkgs; [
            libva
            pkgsi686Linux.libvdpau
            pkgsi686Linux.mesa

            nvidia-vaapi-driver
        ];

        extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    hardware.opentabletdriver.enable = true;
    hardware.opentabletdriver.daemon.enable = true;







}
