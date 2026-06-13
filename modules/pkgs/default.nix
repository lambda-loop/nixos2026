{ pkgs, nixpkgs-unstable, config, ...}: {
    imports = [
        ./unstable-pkgs.nix
    ];

    environment.systemPackages = with pkgs; [ 
        vesktop
        # terminal stuff:
        lsd yazi
    ];


}
