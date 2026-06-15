
{ pkgs, lib, ... }: { 

    services = {
        displayManager.ly.enable = true;
        picom.enable = true;

        xserver.windowManager.xmonad = {
            enable = true;
            enableContribAndExtras = true;
        };
    };

    environment.systemPackages = with pkgs; [
        picom
        xmobar
        dmenu rofi
    ];

#     services = { 
#         displayManager = { 
#             sddm.enable = false;
#             defaultSession = "none+xmonad";
#         };
#
#         # desktopManager.plasma6.enable = true;
#
#         xserver.desktopManager.gnome.enable = true;
#     };
#     environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce "";
#
#     services.xserver.windowManager.xmonad = { 
#         enable = true;
#         enableContribAndExtras = true;
#
#     };
#
#     environment.systemPackages = with pkgs; [
#         wget # picom and rofi are in the home/i3..
#         # TODO: move them..
#
#         dmenu 
#         xmobar
#
#
#         xorg.xmodmap  
#
#
#         sway 
#         waybar
#
#         nitrogen picom
#
#     ];
#
#     # put some wallpaper with the "xwallpaper"
#     # displayManager.sessionCommands = ''
#     #   xwallpaper --zoom ~/walls/wall2.jpg
#     # '';
#
}
