-- General Hyprland options (was: input/general/misc/decoration/dwindle/binds sections)

hl.config({
    input = {
        kb_layout = "br",
        kb_variant = "thinkpad",
        kb_model = "pc105",
        kb_options = "",
        kb_rules = "evdev",
        numlock_by_default = true,
        follow_mouse = 1,
        accel_profile = "flat",
        force_no_accel = true,
        sensitivity = 0,
        touchpad = { natural_scroll = true },
    },

    general = {
        gaps_in = 5,
        gaps_out = 6,
        border_size = 2,
        col = {
            active_border = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
        allow_tearing = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 3,
            passes = 3,
        },
        shadow = {
            enabled = true,
            range = 10,
            render_power = 10,
            color = "rgba(1a1a1aaa)",
        },
    },

    animations = { enabled = true },
    dwindle = { preserve_split = true },
    binds = { allow_workspace_cycles = true },
})
