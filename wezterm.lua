local wezterm = require 'wezterm'

local c = {
  bg          = "#121212",
  fg          = "#c9c9c9",
  tab_bg      = "#121212",
  active_fg   = "#e0e0e0",
  inactive_fg = "#555555",
  hover_bg    = "#1a1a1a",
  border      = "#222222",
  unseen      = "#e07b4a",
}

local process_icons = {
  ["pwsh"]     = wezterm.nerdfonts.md_powershell,
  ["pwsh.exe"] = wezterm.nerdfonts.md_powershell,
  ["cmd"]      = wezterm.nerdfonts.md_console_line,
  ["cmd.exe"]  = wezterm.nerdfonts.md_console_line,
  ["wsl"]      = wezterm.nerdfonts.md_linux,
  ["wsl.exe"]  = wezterm.nerdfonts.md_linux,
  ["bash"]     = wezterm.nerdfonts.cod_terminal_bash,
  ["zsh"]      = wezterm.nerdfonts.dev_terminal,
  ["fish"]     = wezterm.nerdfonts.md_fish,
  ["nvim"]     = wezterm.nerdfonts.custom_vim,
  ["vim"]      = wezterm.nerdfonts.dev_vim,
  ["git"]      = wezterm.nerdfonts.fa_git,
  ["node"]     = wezterm.nerdfonts.md_hexagon,
  ["python"]   = wezterm.nerdfonts.md_language_python,
  ["python3"]  = wezterm.nerdfonts.md_language_python,
  ["docker"]   = wezterm.nerdfonts.linux_docker,
  ["ssh"]      = wezterm.nerdfonts.md_remote_desktop,
}

local function get_process(pane)
  local name = pane.foreground_process_name
  name = name:match("([^/\\]+)$") or name
  return name:lower()
end

local function get_icon(pane)
  return process_icons[get_process(pane)] or wezterm.nerdfonts.md_console
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane  = tab.active_pane
  local icon  = get_icon(pane)
  local proc  = get_process(pane)
  local title = tab.tab_title ~= "" and tab.tab_title or proc

  local has_unseen = false
  if not tab.is_active then
    for _, p in ipairs(tab.panes) do
      if p.has_unseen_output then has_unseen = true break end
    end
  end

  local fg = tab.is_active and c.active_fg
          or (has_unseen    and c.unseen)
          or c.inactive_fg
  local bg = tab.is_active and c.bg or c.tab_bg

  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = "  " .. icon .. "  " .. title .. "  " },
  }
end)

return {
  automatically_reload_config = true,

  default_prog = { "pwsh.exe", "-NoLogo" },
  launch_menu  = {
    { label = "PowerShell",     args = { "pwsh.exe", "-NoLogo" } },
    { label = "Command Prompt", args = { "cmd.exe"             } },
    { label = "WSL",            args = { "wsl.exe"             } },
  },

  font      = wezterm.font_with_fallback({ "CartographCF Nerd Font" }),
  font_size = 13.0,

  color_scheme = "Hacktober",
  colors = {
    foreground    = c.fg,
    background    = c.bg,
    cursor_bg     = "#c8a96e",
    cursor_border = "#c8a96e",
    cursor_fg     = "#141414",
    tab_bar = {
      background         = c.tab_bg,
      active_tab         = { bg_color = c.bg,       fg_color = c.active_fg             },
      inactive_tab       = { bg_color = c.tab_bg,   fg_color = c.inactive_fg           },
      inactive_tab_hover = { bg_color = c.hover_bg, fg_color = c.active_fg, italic = false },
      new_tab            = { bg_color = c.tab_bg,   fg_color = c.inactive_fg           },
      new_tab_hover      = { bg_color = c.hover_bg, fg_color = c.active_fg             },
    },
  },

  window_background_opacity = 0.92,
  win32_system_backdrop     = "Acrylic",

  window_padding = { left = 20, right = 20, top = 16, bottom = 12 },

  enable_tab_bar               = true,
  use_fancy_tab_bar            = true,
  tab_bar_at_bottom            = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width                = 36,

  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_frame = {
    font                 = wezterm.font("CartographCF Nerd Font", { weight = "Bold" }),
    font_size            = 11.0,
    active_titlebar_bg   = c.tab_bg,
    inactive_titlebar_bg = c.tab_bg,
    active_titlebar_fg   = c.fg,
    inactive_titlebar_fg = c.inactive_fg,
    border_left_color    = c.border,
    border_right_color   = c.border,
    border_bottom_color  = c.border,
    border_left_width    = "1px",
    border_right_width   = "1px",
    border_bottom_height = "1px",
  },

  default_cursor_style  = "BlinkingBar",
  cursor_blink_rate     = 800,
  cursor_blink_ease_in  = "EaseIn",
  cursor_blink_ease_out = "EaseOut",

  front_end = "WebGpu",
}
