
{...}: {
    imports = [
        ./xmonad
    ];


    services.xserver.displayManager.sessionCommands = ''
        xrandr --output DP-0 --mode 1920x1080 --rate 360
    '';

}
