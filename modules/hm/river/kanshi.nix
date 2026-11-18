{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "river-session.target";
    settings = [
      {
        profile.name = "desktop";
        profile.outputs = [
          {
            criteria = "DP-2";
            mode = "1920x1080@120Hz";
            position = "1920,0";
          }
          {
            criteria = "DP-1";
            mode = "2560x1440@180Hz";
            position = "0,0";
            adaptiveSync = true;
          }
          {
            criteria = "HDMI-A-1";
            mode = "1920x1080@180Hz";
            position = "0,0";
            adaptiveSync = false;
          }
        ];
      }
    ];
  };
}
