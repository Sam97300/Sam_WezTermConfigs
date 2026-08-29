local wezterm = require 'wezterm'

local c = {
  bg          = "#010101",
  fg          = "#DFDACE",
  tab_bg      = "#0A0A0A",
  active_fg   = "#DFDACE",
  inactive_fg = "#424242",
  hover_bg    = "#181818",
  border      = "#181818",
  unseen      = "#E39236",
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
    { label = "Command Prompt", args = { "cmd.exe"               } },
    { label = "WSL",            args = { "wsl.exe"               } },
  },

  font = wezterm.font({ family = 'MapleMono Nerd Font', weight = 'Thin' }),
  font_size = 13.0,

  colors = {
    foreground    = c.fg,
    background    = c.bg,
    cursor_bg     = "#92734B",
    cursor_border = "#92734B",
    cursor_fg     = "#0E0E0F",

    ansi = {
      "#262729",  -- black
      "#9B1E2B",  -- red
      "#4F9060",  -- green
      "#DA872F",  -- yellow
      "#356075",  -- blue
      "#93372D",  -- purple
      "#64797F",  -- cyan
      "#D3CEC5",  -- white
    },
    brights = {
      "#454646",  -- bright black
      "#A92733",  -- bright red
      "#65BE7E",  -- bright green
      "#E39236",  -- bright yellow
      "#4284A8",  -- bright blue
      "#B55037",  -- bright purple
      "#829FA9",  -- bright cyan
      "#DFDACE",  -- bright white
    },

    selection_fg = "#DFDACE",
    selection_bg = "#6D1F1C",

    tab_bar = {
      background         = c.tab_bg,
      active_tab         = { bg_color = c.bg,       fg_color = c.active_fg              },
      inactive_tab       = { bg_color = c.tab_bg,   fg_color = c.inactive_fg            },
      inactive_tab_hover = { bg_color = c.hover_bg, fg_color = c.active_fg, italic = false },
      new_tab            = { bg_color = c.tab_bg,   fg_color = c.inactive_fg            },
      new_tab_hover      = { bg_color = c.hover_bg, fg_color = c.active_fg              },
    },
  },

  window_background_opacity = 0.92,
  win32_system_backdrop      = "Acrylic",

  window_padding = { left = 20, right = 20, top = 16, bottom = 12 },

  enable_tab_bar               = true,
  use_fancy_tab_bar            = true,
  tab_bar_at_bottom            = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width                = 36,

  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_frame = {
    font = wezterm.font("CartographCF Nerd Font", { weight = "Regular" }),
    font_size = 13.0,
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

  front_end    = "WebGpu",
  audible_bell = "Disabled",
}
