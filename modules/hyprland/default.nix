{lib, pkgs, config, ...}: 
with lib;
let 
  cfg = config.modules.hyprland;
  mainMod = "SUPER";
  lua = lib.generators.mkLuaInline;
  bind = keys: dispatcher: { _args = [keys dispatcher ];};
  dsp = {
    exec       = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close      = lua "hl.dsp.window.close()";
    fullscreen = lua "hl.dsp.window.fullscreen()";
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspaces = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
  };
  workspaceBinds = lib.concatMap ( i:
    let key = toString (lib.mod i 10);
    in [
     (bind "${mainMod} + ${key}" (dsp.focusWorkspace i))
     (bind "${mainMod} + SHIFT + ${key}" (dsp.moveToWorkspace i))
    ]
  ) (lib.range 1 10);
  
in  {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd.variables = ["--all"]; 
      settings = {

        monitor = [{
          output   = "DP-2";
	  mode     = "1920x1080@60.00";
          position = "auto";
          scale    = "auto";
        }{
	  output   = "HDMI-A-1";
          mode     = "1920x1080@180.00";
          position = "auto";
          scale    = "auto";
	}];
    
        bind = [
	  (bind "${mainMod} + RETURN" (dsp.exec "kitty"))
	  (bind "${mainMod} + C" dsp.close)
          (bind "${mainMod} + Z" (dsp.exec "zen-browser"))
          (bind "${mainMod} + F" dsp.fullscreen)
          (bind "${mainMod} + SPACE" (dsp.exec "fuzzel"))
          (bind "${mainMod} + left" (dsp.focus "left"))
          (bind "${mainMod} + right" (dsp.focus "right"))
          (bind "${mainMod} + up" (dsp.focus "up"))
          (bind "${mainMod} + down" (dsp.focus "down"))
          (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
          (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))
        ];
      };
    };
    
    home.packages = with pkgs; [
      mako
      libnotify
    ];
  };  
}
