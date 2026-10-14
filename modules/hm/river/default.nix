{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.river;
  colors = config.lib.stylix.colors;
in
{
  imports = [
    ./kanshi.nix
  ];

  options.modules.river = {
    enable = mkEnableOption "river";
  };

  config = mkIf cfg.enable {
    xdg.configFile."beansprout/config.kdl".text = ''
            attach_mode top
            primary_count 1
            primary_ratio 0.55
            single_window_ratio 0.70
            primary_side left 
            focus_follows_pointer #true
            output_focus_follows_pointer #true
            pointer_warp_on_focus_change #true
            restore_focus #true
            focus_on_send if_visible
            focus_next_direction next

            wallpaper_image_path "/home/goofy/dotfiles/assets/backgrounds/gruv_bliss.png"

            borders {
                width 2
                color_focused "0x${colors.base0D}"
                color_unfocused "0x${colors.base02}"
            }
            bar {
                background_color "0x${colors.base01}"
      	  text_color "0x${colors.base06}"
                position top
                time_format "%H:%M"
            }
            window_rules {
                float app_id="firefox" title="Picture-in-Picture"
                float title="*Preferences*"
                no_float app_id="mpv"
                tags 0x0004 app_id="Slack"
            }
            keybinds {
                spawn Mod4 T kitty
                spawn Mod4 R fuzzel
                focus_next_window Mod4 J
                focus_prev_window Mod4 K
                focus_next_output Mod4 Period
                focus_prev_output Mod4 Comma
                send_to_next_output Mod4+Shift Period
                send_to_prev_output Mod4+Shift Comma
                zoom Mod4 Z
                toggle_float Mod4+Shift F
                change_primary_ratio Mod4 H 0.05
                change_primary_ratio Mod4 L -0.05
                increment_primary_count Mod4 I
                decrement_primary_count Mod4 D
                reload_config Mod4+Shift R
                toggle_fullscreen Mod4 F
                close_window Mod4+Shift Q
                exit_river Ctrl+Alt Delete
                swap_next Mod4+Shift N
                swap_prev Mod4+Shift P
                move_left Mod4+Shift H 100
                move_down Mod4+Shift J 100
                move_up Mod4+Shift K 100
                move_right Mod4+Shift L 100
                resize_width Mod4+Alt+Shift H -100
                resize_height Mod4+Alt+Shift J 100
                resize_height Mod4+Alt+Shift K -100
                resize_width Mod4+Alt+Shift L 100
                tag_bind Mod4 set_output_tags
                tag_bind Mod4+Shift set_window_tags
                tag_bind Mod4+Ctrl toggle_output_tags
                tag_bind Mod4+Ctrl+Shift toggle_window_tags
            }
            pointer_binds {
                move_window Mod4 BTN_LEFT
                resize_window Mod4 BTN_RIGHT
            }

            keyboard_layout {
                layout "us"
                options "compose:rctrl"
            }
            input {
                accel_profile "flat"
            }
            tag_overlay {
                tag_amount 10
                background_color "0x${colors.base00}"
                border_color "0x${colors.base09}"
                square_active_background_color "0x${colors.base0D}"
                square_active_border_color "0x${colors.base03}"
                square_active_occupied_color "0x${colors.base05}"
                square_inactive_background_color "0x${colors.base02}"
                square_inactive_border_color "0x${colors.base03}"
                square_inactive_occupied_color "0x${colors.base05}"
            }
    '';

    services.fnott.enable = true;
  };
}
