local wezterm = require("wezterm")

wezterm.on("gui-startup", function()
  local _, _, mux_window = wezterm.mux.spawn_window({})
  local gui_window = mux_window:gui_window()
  if gui_window then
    local dims = gui_window:get_dimensions()
    local screen = wezterm.gui.screens().main
    local x = screen.x + math.floor((screen.width - dims.pixel_width) / 2)
    local y = screen.y + math.floor((screen.height - dims.pixel_height) / 2)
    gui_window:set_position(x, y)
  end
end)

return {
  -- 设置窗口半透明
  window_background_opacity = 0.85,
  macos_window_background_blur = 15,
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 13.0,
  initial_cols = 150,
  initial_rows = 35,
  default_prog = { "/bin/zsh", "-l" },
  tab_max_width = 32,
  exit_behavior = "Close",
  scrollback_lines = 10000,
  window_padding = { left = 8, right = 8, top = 6, bottom = 6 },
  launch_menu = {
    { label = "zsh", args = { "/bin/zsh", "-l" } },
    { label = "bash", args = { "/bin/bash", "-l" } },
  },
  -- 新增：显式绑定 Command 和 Option 方向键
  keys = {
    -- Option + 左/右箭头：按词移动 (发送 bash/zsh 兼容的序列)
    { key = 'LeftArrow', mods = 'OPT', action = wezterm.action.SendString '\x1bb' },
    { key = 'RightArrow', mods = 'OPT', action = wezterm.action.SendString '\x1bf' },

    -- Command + 左/右箭头：移动至行首/行尾 (映射为 Ctrl+A 和 Ctrl+E)
    { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.SendString '\x01' },
    { key = 'RightArrow', mods = 'CMD', action = wezterm.action.SendString '\x05' },
  },
}
