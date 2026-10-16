-- Input configuration

hl.config({
    input = {
        -- sensitivity = -0.25,
        kb_layout = "us",
        kb_variant = "intl",
        accel_profile = "flat",
        kb_options = "caps:swapescape",
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
