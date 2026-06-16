{ config, pkgs, ... }: {

  services.kanata = {
    enable = true;

    keyboards.my-keyboard = {
      devices = [ 
        # /dev/input/event0:      ROYUAN Gaming Keyboard
        # "/dev/input/by-id/usb-ROYUAN_Gaming_Keyboard-event-kbd"
        "/dev/input/by-id/usb-ROYUAN_Gaming_Keyboard-event-kbd" 
      ];

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
      
      # Aponta para o seu arquivo de layout do Kanata
      config = builtins.readFile ./layout.kbd;
    };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us"; 
      variant = "";
      options = "compose:ralt";  
    };
  };

}
