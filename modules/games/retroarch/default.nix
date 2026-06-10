{lib, config, pkgs, ...}:
with lib;
let cfg = config.modules.retroarch;
bios = {
  ps1 = {
    scph5500 = pkgs.fetchurl {
      url = "https://archive.org/download/the-ultimate-playstation-1-bios/scph5500.bin";
      sha256 = "1nzawyshxq24954bhzkjy1ps6nldxapri1p1mgs0ay11is2j214w";
    };
    
    scph5501 = pkgs.fetchurl {
      url = "https://archive.org/download/the-ultimate-playstation-1-bios/scph5501.bin";
      sha256 = "1vqzib7p3sai4j8qf0v8cs743a9ld35zkc89lzqbnrp4k5j2n18i";
    };
  };
  ps2 = {
    ps2-0230e-20080220 = pkgs.fetchurl {
      url = "https://archive.org/download/ps2-bios-megadump/PS2_BIOS.zip/ps2-0230e-20080220.bin";
      sha256 = "0saf43zg2kgnx335kmlwm0r1qa1ib3dxgd602ahb5qp8l3yr2nnb";
    };
  };
};
in {
  options.modules.retroarch = { enable = mkEnableOption "retro arch";  };
  config = mkIf cfg.enable {
    programs.retroarch = {
      enable = true;
      cores = {
        dolphin.enable = true;
        parallel-n64.enable = true;
        pcsx2.enable = true;
        swanstation.enable = true;
      };
      settings = {
        video_driver = "vulkan";
        netplay_nickname = "ToadHog";
        menu_driver = "ozone";
        ozone_menu_color_theme = "Nord";
      };
    };
    home.file = lib.mapAttrs' (name: source: {
      name = ".config/retroarch/system/${name}.bin";
      value = { inherit source; };
    }) bios.ps1 //
    lib.mapAttrs' (name: source: {
      name = ".config/retroarch/system/pcsx2/bios/${name}.bin";
      value = { inherit source; };
    }) bios.ps2;
  };
}
