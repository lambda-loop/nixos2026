
{...}: {
    imports = [
        ./xmonad
    ];

    services.xserver = {
        enable = true;
        videoDrivers = [ "nvidia" ];
        screenSection = ''
            Option "DPMS" "false"
        '';

        displayManager.sessionCommands = ''
        xrandr --output DP-0 --mode 1920x1080 --rate 360
        '';
    };


    # services.xserver.displayManager.sessionCommands = ''
    #     xrandr --output DP-0 --mode 1920x1080 --rate 360
    # '';

}
