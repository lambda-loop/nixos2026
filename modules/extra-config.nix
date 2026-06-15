{ pkgs, config, ... } : {

    # -----------------------------------------------------------------
    # Gaming Compatibility
    # -----------------------------------------------------------------
    hardware = {
        graphics = {
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

        opentabletdriver.enable = true;
        opentabletdriver.daemon.enable = true;
    };

    # Otimiza o clock do CPU e prioridade do sistema ao abrir jogos
    # programs.gamemode.enable = true;

    # monitor 360 pls
    # boot.kernelParams = [ 
    #     "nvidia-drm.modeset=1" 
    #     "video=DP-1:1920x1080@360" 
    # ];


    # services.xserver.displayManager.setupCommands = ''
    #     ${pkgs.xorg.xrandr}/bin/xrandr --newmode "1920x1080R" 969.00 1920 1968 2000 2080 1080 1083 1088 1295 +hsync -vsync
    #     ${pkgs.xorg.xrandr}/bin/xrandr --addmode DP-1 "1920x1080R"
    #     ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode "1920x1080R"
    # '';

    ## OLD but BETTER version:
    # services.xserver.displayManager.sessionCommands = ''
    #     xrandr --output DP-0 --mode 1920x1080 --rate 360
    # '';


    # NVIDIA 
    hardware.nvidia = {
        open                   = false;
        modesetting.enable     = true;
        powerManagement.enable = false;
        nvidiaSettings         = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        # package = config.boot.kernelPackages.nvidiaPackages.latest; 
    };

    # NO VSYNC
    # environment.sessionVariables = {
    #     __GL_SYNC_TO_VBLANK = "0";
    # };


}



