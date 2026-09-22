{ ... }: {
  wayland.windowManager.wayfire.settings = {
    "output:HDMI-A-1" = {
      mode = "1920x1080@180000";
      position = "0,0";
      transform = "normal";
      scale = "1.000000";
    };

    "output:DP-2" = {
      mode = "1920x1080@60000";
      position = "1920,0";
      transform = "normal";
      scale = "1.000000";
    };

    autostart = {
      "0_uwsm_finalize" = "uwsm finalize UWSM_ID UWSM_APP_UNIT_TYPE UWSM_USE_SESSION_SLICE";
      "1_wf_background" = "uwsm app -- wf-background";
      autostart_wf_shell = false;
      notifications = "uwsm app -- mako";
    };

    core.plugins = "autostart command move resize scale animate panel cube  animate  expo fast-switcher  foreign-toplevel grid gtk-shell idle invert oswitch place resize session-lock shortcuts-inhibit switcher vswitch wobbly wrot wsets zoom wayfire-shell wm-actions window-rules";

    command = {
      binding_close = "<super> KEY_Q";
      command_close = "wayfire-close";

      binding_terminal = "<super> KEY_ENTER";
      command_terminal = "uwsm app -- kitty";

      binding_launcher = "<super> <shift> KEY_ENTER";
      command_launcher = "uwsm app -- fuzzel";
    };

    cube = {
      active = "<super> <alt> btn_left";
      rotate_left = "<super> <alt> KEY_LEFT";
      rotate_right = "<super> <alt> KEY_RIGHT";
    };

    wayfire-shell = {
      toggle_menu = "<super>";
    };

    wm-actions = {
      toggle_fullscreen = "<super> KEY_F";
    };
  };
}
