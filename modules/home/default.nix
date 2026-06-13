{ config, pkgs, inputs, system, ...}: {

  imports = [
    ./editor
    ./keyboard
    ./programs
    ./shell
    ./i3
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default

    gnome-randr
  ];

  home = {
    username = "jjoaoll";
    homeDirectory = "/home/jjoaoll";
    stateVersion = "25.05";
  };



    systemd.user.services.force-360hz = {
        Unit = {
            Description = "Forçar 360Hz no monitor via gnome-randr";
            After = [ "graphical-session.target" ];
        };
        Install = {
            WantedBy = [ "graphical-session.target" ];
        };
        Service = {
            # Note que o xrandr chamava de DP-0, mas no Wayland pode ser DP-1 ou DP-2. 
            # Você pode rodar `gnome-randr` no terminal antes para confirmar o nome exato.
            ExecStart = "${pkgs.gnome-randr}/bin/gnome-randr modify DP-1 --mode 1920x1080@360";
            Type = "oneshot";
        };
    };

}
