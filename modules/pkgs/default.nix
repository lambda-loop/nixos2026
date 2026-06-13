{ pkgs, nixpkgs-unstable, config, ...}: {
    imports = [
        ./unstable-pkgs.nix
    ];

    environment.systemPackages = with pkgs; [ 
        vesktop krita
        # terminal stuff:
        lsd yazi


        #(import (builtins.fetchTarball "https://github.com/notgne2/osu-nixos/archive/refs/heads/master.tar.gz")).packages.${pkgs.system}.osu-lazer
        # GAMMING 
        gamemode gamescope
        steam steam-run protonup-ng
        pkgsi686Linux.libGL pkgsi686Linux.glibc pkgsi686Linux.zlib
        protonup-qt vulkan-loader vulkan-tools
        # STREAMING
        obs-studio
        (pkgs.wrapOBS {
            plugins = with pkgs.obs-studio-plugins; [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
            ];
        })


    ];


}
