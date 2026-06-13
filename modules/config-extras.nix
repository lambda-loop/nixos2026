{ config, pkgs, ... }: {
    services.emacs = {
        enable = true;
        # defaultEditor = true;
    };

    # GTK THINGS
    services.xserver.desktopManager.gnome.enable = true;
    programs.dconf.enable = true;
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
        config.common.default = "gnome";
    };

    environment.systemPackages = with pkgs; [
        flatpak
        flatpak-builder
        gnome-software
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
    hardware.nvidia = {
        open                   = false;
        modesetting.enable     = true;
        powerManagement.enable = true;
        nvidiaSettings         = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

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
