local wezterm = require 'wezterm'
local mux = wezterm.mux
wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window{}
    window:gui_window():maximize()
end)

local config = {}
config.font_size = 24
config.font = wezterm.font('Ubuntu Mono', { weight = 'Medium', italic = false })
config.window_close_confirmation = 'NeverPrompt'
return config
