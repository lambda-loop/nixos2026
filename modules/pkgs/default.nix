{ pkgs, nixpkgs-unstable, config, ...}: {

  environment.systemPackages = with pkgs; [ 
    vesktop
    zig zls lldb


    # terminal stuff:
    lsd yazi
  ];


}
