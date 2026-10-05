{ ... }: {
  services.wpaperd = {
    enable = true;
    settings = {
      path = ../../../assests/backgrounds;
      duration = "30m";
      sorting = "random";
      mode = "center";
    };
  };

}
