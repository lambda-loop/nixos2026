{ pkgs, ... } : {

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



}
