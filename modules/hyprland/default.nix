{lib, pkgs, config, ...}: 
with lib;
let 
  cfg = config.modules.hyprland;
  mainMod = "SUPER";
  lua = lib.generators.mkLuaInline;
  bind = keys: dispatcher: { _args = [keys dispatcher ];};
  bindOpts = keys: dispatcher: opts: { _args = [keys dispatcher opts]; };
  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    fullscreen = lua "hl.dsp.window.fullscreen()";
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
  };
  workspaceBinds = lib.concatMap ( i:
    let key = toString (lib.mod i 10);
    in [
     (bind "SUPER + ${key}" (dsp.focusWorkspace i))
     (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
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
	  (bind "SUPER + RETURN" (dsp.exec "kitty"))
	  (bind "SUPER + C" (dsp.close))
          (bind "SUPER + Z" (dsp.exec "zen-beta"))
	  (bind "SUPER + F" (dsp.fullscreen))
          (bind "SUPER + left" (dsp.focus "left"))
          (bind "SUPER + right" (dsp.focus "right"))
          (bind "SUPER + up" (dsp.focus "up"))
          (bind "SUPER + down" (dsp.focus "down"))
          (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
          (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))
          (bindOpts "SUPER + mouse:272" dsp.drag { mouse = true; })
          (bindOpts "SUPER + mouse:273" dsp.resize { mouse = true; })
        ] ++ workspaceBinds;
      };
    };
    
    home.packages = with pkgs; [
      mako
      libnotify
    ];
  };  
}
