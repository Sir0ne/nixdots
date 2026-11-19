{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "river-session.target";
    settings = [
      {
        profile.name = "desktop";
        profile.outputs = [
          {
            criteria = "Shenzhen KTC Technology Group H24T7 0x00000001";
            mode = "2560x1440@180Hz";
            position = "0,0";
            scale = 1.0;
            adaptiveSync = true;
          }
        ];
      }
    ];
  };
}
